"use strict";

const SOCKET_URL = "ws://127.0.0.1:16898";
const pressedKeys = new Set();
const pressedButtons = new Set();

const historyList = document.getElementById("history-list");
const connection = document.getElementById("connection");
const motionDot = document.getElementById("motion-dot");
const wheelUp = document.getElementById("wheel-up");
const wheelDown = document.getElementById("wheel-down");

let socket;
let reconnectTimer;
let motionTimer;
let wheelTimer;
let inputHighlightsEnabled = false;

function setInputHighlightsEnabled(enabled) {
  inputHighlightsEnabled = Boolean(enabled);
  resetState();
}

function codesFor(element, attribute) {
  const raw = element.getAttribute(attribute);
  if (!raw) return [];
  return raw
    .split(",")
    .map((value) => value.trim())
    .filter(Boolean)
    .map(Number);
}

function controlIsActive(element) {
  const keyActive =
    element.hasAttribute("data-codes") &&
    codesFor(element, "data-codes").some((code) => pressedKeys.has(code));

  const buttonActive =
    element.hasAttribute("data-button") &&
    pressedButtons.has(Number(element.getAttribute("data-button")));

  return keyActive || buttonActive;
}

function updateKeys() {
  document.querySelectorAll("[data-codes]").forEach((element) => {
    element.classList.toggle("active", controlIsActive(element));
  });
}

function updateButtons() {
  document.querySelectorAll("[data-button]").forEach((element) => {
    element.classList.toggle("active", controlIsActive(element));
  });
}

function addHistory(label, mouseEvent = false) {
  if (!historyList) return;
  const item = document.createElement("li");
  item.textContent = label;
  item.classList.toggle("mouse-event", mouseEvent);
  historyList.append(item);
  while (historyList.children.length > 6) {
    historyList.firstElementChild.remove();
  }
  window.setTimeout(() => item.remove(), 4500);
}

function showMotion(dx, dy) {
  if (!motionDot) return;
  const x = Math.max(-34, Math.min(34, dx * 1.7));
  const y = Math.max(-34, Math.min(34, dy * 1.7));
  motionDot.style.transform = `translate(calc(-50% + ${x}px), calc(-50% + ${y}px))`;
  motionDot.classList.add("active");
  window.clearTimeout(motionTimer);
  motionTimer = window.setTimeout(() => {
    motionDot.style.transform = "translate(-50%, -50%)";
    motionDot.classList.remove("active");
  }, 100);
}

function showWheel(y) {
  if (!wheelUp || !wheelDown) return;
  const element = y > 0 ? wheelUp : wheelDown;
  element.classList.add("active");
  window.clearTimeout(wheelTimer);
  wheelTimer = window.setTimeout(() => {
    wheelUp.classList.remove("active");
    wheelDown.classList.remove("active");
  }, 160);
}

function handleMessage(event) {
  const data = JSON.parse(event.data);

  if (data.type === "snapshot") {
    setInputHighlightsEnabled(data.visible);
    if (!inputHighlightsEnabled) return;

    data.keys.forEach((code) => pressedKeys.add(code));
    data.buttons.forEach((code) => pressedButtons.add(code));
    updateKeys();
    updateButtons();
    return;
  }

  if (data.type === "visibility") {
    setInputHighlightsEnabled(data.visible);
    return;
  }

  if (!inputHighlightsEnabled) return;

  if (data.type === "key") {
    if (data.down) {
      pressedKeys.add(data.code);
      if (!data.repeat) addHistory(data.name);
    } else {
      pressedKeys.delete(data.code);
    }
    updateKeys();
    updateButtons();
    return;
  }

  if (data.type === "mouse_button") {
    if (data.down) {
      pressedButtons.add(data.code);
      if (!data.repeat) addHistory(data.name, true);
    } else {
      pressedButtons.delete(data.code);
    }
    updateButtons();
    updateKeys();
    return;
  }

  if (data.type === "mouse_move") {
    showMotion(data.dx, data.dy);
    return;
  }

  if (data.type === "wheel" && data.y) {
    showWheel(data.y);
    addHistory(data.y > 0 ? "Wheel Up" : "Wheel Down", true);
  }
}

function resetState() {
  pressedKeys.clear();
  pressedButtons.clear();
  updateKeys();
  updateButtons();
}

function connect() {
  window.clearTimeout(reconnectTimer);
  socket = new WebSocket(SOCKET_URL);

  socket.addEventListener("open", () => {
    if (connection) connection.classList.add("online");
  });

  socket.addEventListener("message", handleMessage);

  socket.addEventListener("close", () => {
    if (connection) connection.classList.remove("online");
    setInputHighlightsEnabled(false);
    reconnectTimer = window.setTimeout(connect, 1000);
  });

  socket.addEventListener("error", () => socket.close());
}

connect();

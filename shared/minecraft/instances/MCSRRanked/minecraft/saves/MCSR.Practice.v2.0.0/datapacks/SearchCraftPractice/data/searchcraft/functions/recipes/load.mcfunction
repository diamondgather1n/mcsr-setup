execute store result score goals item_detector run data get storage searchcraft:recipes recipes_enabled[{selected:1b}].goals
function searchcraft:load_inventory
gamemode adventure @a
kill @e[type=item]
scoreboard players set active timer 1
scoreboard players set timer timer 0
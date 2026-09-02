scoreboard objectives add timer.temp dummy "\u00A7aTimerTemp"
scoreboard players set #5 timer.temp 5
scoreboard players set #20 timer.temp 20
scoreboard players set #60 timer.temp 60
scoreboard players set #1200 timer.temp 1200
execute unless score start_tick timer.temp = start_tick timer.temp run scoreboard players set start_tick timer.temp 0
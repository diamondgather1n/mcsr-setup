# Calculate time
scoreboard players operation minutes timer.temp = tick timer.temp
scoreboard players operation minutes timer.temp /= #1200 timer.temp

scoreboard players operation seconds timer.temp = tick timer.temp
scoreboard players operation seconds timer.temp /= #20 timer.temp
scoreboard players operation seconds timer.temp %= #60 timer.temp

# Pad seconds with 0s in storage
data modify storage timer seconds set value [0, 0]
execute if score seconds timer.temp matches 10.. run data remove storage timer seconds[1]
execute store result storage timer seconds[-1] int 1 run scoreboard players get seconds timer.temp

# Increment tick counter
scoreboard players add tick timer.temp 1

# Schedule next tick
schedule function timer:tick 1t
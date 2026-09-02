# Calculate miliseconds
scoreboard players operation miliseconds timer.temp = tick timer.temp
scoreboard players operation miliseconds timer.temp %= #20 timer.temp
scoreboard players operation miliseconds timer.temp *= #5 timer.temp

# Pad miliseconds with 0s in storage
data modify storage timer miliseconds set value [0, 0]
execute if score miliseconds timer.temp matches 10.. run data remove storage timer miliseconds[1]
execute store result storage timer miliseconds[-1] int 1 run scoreboard players get miliseconds timer.temp
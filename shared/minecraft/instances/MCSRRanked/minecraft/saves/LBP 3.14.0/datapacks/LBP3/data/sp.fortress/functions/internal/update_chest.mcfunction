scoreboard players operation $max sp.utils.rng = $chest_p sp.fortress
function sp.utils:rng/next_int

execute unless score $out sp.utils.rng matches 1 run data modify block ~ ~ ~ LootTable set value ""
execute unless score $out sp.utils.rng matches 1 run setblock ~ ~ ~ air
execute if score $out sp.utils.rng matches 1 run scoreboard players add $current sp.utils.rng 1
execute if score $out sp.utils.rng matches 1 store result block ~ ~ ~ LootTableSeed long 1 run scoreboard players get $current sp.utils.rng
scoreboard objectives add sp.utils.rng dummy "\u00A7eUtils RNG"

scoreboard players set #32768 sp.utils.rng 32768
scoreboard players set #65536 sp.utils.rng 65536
scoreboard players set #1103515245 sp.utils.rng 1103515245
scoreboard players set #-2147483648 sp.utils.rng -2147483648

execute unless score $max sp.utils.rng = $max sp.utils.rng run scoreboard players set $max sp.utils.rng 100
execute unless score $out sp.utils.rng = $out sp.utils.rng run scoreboard players set $out sp.utils.rng 0

function sp.utils:rng/generate_seed
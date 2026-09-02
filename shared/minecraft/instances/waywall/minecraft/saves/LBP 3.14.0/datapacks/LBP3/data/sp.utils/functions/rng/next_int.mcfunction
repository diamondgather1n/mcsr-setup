scoreboard players operation $current sp.utils.rng *= #1103515245 sp.utils.rng
execute store result score #lower sp.utils.rng run scoreboard players add $current sp.utils.rng 12345
scoreboard players operation #lower sp.utils.rng /= #65536 sp.utils.rng
scoreboard players operation $current sp.utils.rng *= #1103515245 sp.utils.rng
execute store result score $out sp.utils.rng run scoreboard players add $current sp.utils.rng 12345
scoreboard players operation $out sp.utils.rng /= #32768 sp.utils.rng
scoreboard players operation $out sp.utils.rng *= #32768 sp.utils.rng
execute if score #lower sp.utils.rng matches ..-1 if score $out sp.utils.rng matches 0.. run scoreboard players operation $out sp.utils.rng += #-2147483648 sp.utils.rng
execute if score #lower sp.utils.rng matches 0.. if score $out sp.utils.rng matches ..-1 run scoreboard players operation $out sp.utils.rng += #-2147483648 sp.utils.rng
scoreboard players operation $out sp.utils.rng += #lower sp.utils.rng
execute store result score $out sp.utils.rng run scoreboard players operation $out sp.utils.rng %= $max sp.utils.rng
scoreboard players add $out sp.utils.rng 1
scoreboard players operation current bastion.rng *= $1103515245 bastion.rng
execute store result score $lower bastion.rng run scoreboard players add current bastion.rng 12345
scoreboard players operation $lower bastion.rng /= $65536 bastion.rng
scoreboard players operation current bastion.rng *= $1103515245 bastion.rng
execute store result score out bastion.rng run scoreboard players add current bastion.rng 12345
scoreboard players operation out bastion.rng /= $32768 bastion.rng
scoreboard players operation out bastion.rng *= $32768 bastion.rng
execute if score $lower bastion.rng matches ..-1 if score out bastion.rng matches 0.. run scoreboard players operation out bastion.rng += $-2147483648 bastion.rng
execute if score $lower bastion.rng matches 0.. if score out bastion.rng matches ..-1 run scoreboard players operation out bastion.rng += $-2147483648 bastion.rng
scoreboard players operation out bastion.rng += $lower bastion.rng
execute store result score out bastion.rng run scoreboard players operation out bastion.rng %= max bastion.rng
scoreboard players add out bastion.rng 1
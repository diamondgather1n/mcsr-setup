scoreboard players set max bastion.rng 8
function bastionbuilder:internal/utils/rng/new_int

execute if score random_gold bastion.settings matches 0 if score out bastion.rng matches 1..2 run setblock ~ ~ ~ gold_block
execute if score random_gold bastion.settings matches 1 if score out bastion.rng matches 1..5 run setblock ~ ~ ~ gold_block
execute if score random_gold bastion.settings matches 2 run setblock ~ ~ ~ gold_block
fill ~ ~ ~ ~ ~1 ~ air
execute if score random_gold bastion.settings matches 0 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "COUNTERCLOCKWISE_90", integrity: 0.3f, name: "bastionbuilder:processors/treasure/ramparts/top_wall/processor_0"}
execute if score random_gold bastion.settings matches 1 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "COUNTERCLOCKWISE_90", integrity: 0.15f, name: "bastionbuilder:processors/treasure/ramparts/top_wall/processor_0"}
function bastionbuilder:internal/utils/update_jigsaw_seed
setblock ~ ~1 ~ redstone_block
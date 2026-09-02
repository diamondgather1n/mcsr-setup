fill ~ ~ ~ ~ ~1 ~ air
execute if score random_gold bastion.settings matches 0 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "CLOCKWISE_90", integrity: 0.1f, name: "bastionbuilder:processors/hoglin_stable/walls/side_wall_1/processor_1"}
execute if score random_gold bastion.settings matches 1 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "CLOCKWISE_90", integrity: 0.05f, name: "bastionbuilder:processors/hoglin_stable/walls/side_wall_1/processor_1"}
function bastionbuilder:internal/utils/update_jigsaw_seed
setblock ~ ~1 ~ redstone_block
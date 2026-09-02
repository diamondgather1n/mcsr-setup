fill ~ ~ ~ ~ ~1 ~ air
execute if score random_gold bastion.settings matches 0 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "CLOCKWISE_90", integrity: 0.6f, name: "bastionbuilder:processors/bridge/starting_pieces/entrance/processor_1"}
execute if score random_gold bastion.settings matches 1 run setblock ~ ~ ~ structure_block{mode: LOAD, rotation: "CLOCKWISE_90", integrity: 0.3f, name: "bastionbuilder:processors/bridge/starting_pieces/entrance/processor_1"}
function bastionbuilder:internal/utils/update_jigsaw_seed
setblock ~ ~1 ~ redstone_block
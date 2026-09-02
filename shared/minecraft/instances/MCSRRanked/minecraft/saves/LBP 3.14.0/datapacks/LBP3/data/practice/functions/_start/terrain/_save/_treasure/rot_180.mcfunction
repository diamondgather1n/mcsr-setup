# Clone existing terrain blocks to height limit
clone ~-46 ~-2 ~-89 ~-47 ~-1 ~-89 ~-47 254 ~-89
clone ~-46 ~-2 ~-47 ~-47 ~-1 ~-47 ~-47 254 ~-47
clone ~-58 ~-2 ~-47 ~-59 ~-1 ~-47 ~-59 254 ~-47
clone ~-58 ~-2 ~-89 ~-59 ~-1 ~-89 ~-59 254 ~-89

# Create structure blocks to save terrain
setblock ~-47 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~-47 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:35, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~-47 ~-2 ~-89 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:42, name:"practice:rerun_terrain/0_0_1"}
setblock ~-47 ~-1 ~-89 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:35, sizeZ:42, name:"practice:rerun_terrain/0_1_1"}

setblock ~-59 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:12, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/1_0_0"}
setblock ~-59 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:12, sizeY:35, sizeZ:48, name:"practice:rerun_terrain/1_1_0"}

setblock ~-59 ~-2 ~-89 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:12, sizeY:47, sizeZ:42, name:"practice:rerun_terrain/1_0_1"}
setblock ~-59 ~-1 ~-89 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:12, sizeY:35, sizeZ:42, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~-46 ~-2 ~-89 ~-46 ~-1 ~-89 redstone_block
fill ~-46 ~-2 ~-47 ~-46 ~-1 ~-47 redstone_block
fill ~-58 ~-2 ~-47 ~-58 ~-1 ~-47 redstone_block
fill ~-58 ~-2 ~-89 ~-58 ~-1 ~-89 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~-47 254 ~-89 ~-46 255 ~-89 ~-47 ~-2 ~-89 replace
clone ~-47 254 ~-47 ~-46 255 ~-47 ~-47 ~-2 ~-47 replace
clone ~-59 254 ~-47 ~-58 255 ~-47 ~-59 ~-2 ~-47 replace
clone ~-59 254 ~-89 ~-58 255 ~-89 ~-59 ~-2 ~-89 replace

# Replace the blocks at height limit with air
fill ~-47 254 ~-89 ~-46 255 ~-89 air
fill ~-47 254 ~-47 ~-46 255 ~-47 air
fill ~-59 254 ~-47 ~-58 255 ~-47 air
fill ~-59 254 ~-89 ~-58 255 ~-89 air
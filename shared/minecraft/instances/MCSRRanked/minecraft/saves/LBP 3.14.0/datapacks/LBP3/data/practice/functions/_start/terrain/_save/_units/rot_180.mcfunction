# Clone existing terrain blocks to height limit
clone ~-46 ~-2 ~-69 ~-47 ~-1 ~-69 ~-47 254 ~-69
clone ~-46 ~-2 ~-47 ~-47 ~-1 ~-47 ~-47 254 ~-47
clone ~-82 ~-2 ~-47 ~-83 ~-1 ~-47 ~-83 254 ~-47
clone ~-82 ~-2 ~-69 ~-83 ~-1 ~-69 ~-83 254 ~-69

# Create structure blocks to save terrain
setblock ~-47 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~-47 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~-47 ~-2 ~-69 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:22, name:"practice:rerun_terrain/0_0_1"}
setblock ~-47 ~-1 ~-69 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:22, name:"practice:rerun_terrain/0_1_1"}

setblock ~-83 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:36, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/1_0_0"}
setblock ~-83 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:36, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/1_1_0"}

setblock ~-83 ~-2 ~-69 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:36, sizeY:47, sizeZ:22, name:"practice:rerun_terrain/1_0_1"}
setblock ~-83 ~-1 ~-69 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:36, sizeY:21, sizeZ:22, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~-46 ~-2 ~-69 ~-46 ~-1 ~-69 redstone_block
fill ~-46 ~-2 ~-47 ~-46 ~-1 ~-47 redstone_block
fill ~-82 ~-2 ~-47 ~-82 ~-1 ~-47 redstone_block
fill ~-82 ~-2 ~-69 ~-82 ~-1 ~-69 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~-47 254 ~-69 ~-46 255 ~-69 ~-47 ~-2 ~-69 replace
clone ~-47 254 ~-47 ~-46 255 ~-47 ~-47 ~-2 ~-47 replace
clone ~-83 254 ~-47 ~-82 255 ~-47 ~-83 ~-2 ~-47 replace
clone ~-83 254 ~-69 ~-82 255 ~-69 ~-83 ~-2 ~-69 replace

# Replace the blocks at height limit with air
fill ~-47 254 ~-69 ~-46 255 ~-69 air
fill ~-47 254 ~-47 ~-46 255 ~-47 air
fill ~-83 254 ~-47 ~-82 255 ~-47 air
fill ~-83 254 ~-69 ~-82 255 ~-69 air
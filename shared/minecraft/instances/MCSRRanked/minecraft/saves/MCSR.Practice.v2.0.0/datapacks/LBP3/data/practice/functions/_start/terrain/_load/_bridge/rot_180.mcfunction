# Clone existing terrain blocks to height limit
clone ~-46 ~-2 ~-83 ~-47 ~-1 ~-83 ~-47 254 ~-83
clone ~-46 ~-2 ~-47 ~-47 ~-1 ~-47 ~-47 254 ~-47
clone ~-73 ~-2 ~-47 ~-74 ~-1 ~-47 ~-74 254 ~-47
clone ~-73 ~-2 ~-83 ~-74 ~-1 ~-83 ~-74 254 ~-83

# Create structure blocks to save terrain
setblock ~-47 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~-47 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~-47 ~-2 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/0_0_1"}
setblock ~-47 ~-1 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:36, name:"practice:rerun_terrain/0_1_1"}

setblock ~-74 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:27, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/1_0_0"}
setblock ~-74 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:27, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/1_1_0"}

setblock ~-74 ~-2 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:27, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/1_0_1"}
setblock ~-74 ~-1 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:27, sizeY:30, sizeZ:36, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~-46 ~-2 ~-83 ~-46 ~-1 ~-83 redstone_block
fill ~-46 ~-2 ~-47 ~-46 ~-1 ~-47 redstone_block
fill ~-73 ~-2 ~-47 ~-73 ~-1 ~-47 redstone_block
fill ~-73 ~-2 ~-83 ~-73 ~-1 ~-83 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~-47 254 ~-83 ~-46 255 ~-83 ~-47 ~-2 ~-83 replace
clone ~-47 254 ~-47 ~-46 255 ~-47 ~-47 ~-2 ~-47 replace
clone ~-74 254 ~-47 ~-73 255 ~-47 ~-74 ~-2 ~-47 replace
clone ~-74 254 ~-83 ~-73 255 ~-83 ~-74 ~-2 ~-83 replace

# Replace the blocks at height limit with air
fill ~-47 254 ~-83 ~-46 255 ~-83 air
fill ~-47 254 ~-47 ~-46 255 ~-47 air
fill ~-74 254 ~-47 ~-73 255 ~-47 air
fill ~-74 254 ~-83 ~-73 255 ~-83 air
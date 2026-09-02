# Clone existing terrain blocks to height limit
clone ~-46 ~-2 ~-67 ~-47 ~-1 ~-67 ~-47 254 ~-67
clone ~-46 ~-2 ~-47 ~-47 ~-1 ~-47 ~-47 254 ~-47
clone ~-68 ~-2 ~-47 ~-69 ~-1 ~-47 ~-69 254 ~-47
clone ~-68 ~-2 ~-67 ~-69 ~-1 ~-67 ~-69 254 ~-67

# Create structure blocks to save terrain
setblock ~-47 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~-47 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~-47 ~-2 ~-67 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:20, name:"practice:rerun_terrain/0_0_1"}
setblock ~-47 ~-1 ~-67 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:20, name:"practice:rerun_terrain/0_1_1"}

setblock ~-69 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:22, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/1_0_0"}
setblock ~-69 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:22, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/1_1_0"}

setblock ~-69 ~-2 ~-67 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:22, sizeY:47, sizeZ:20, name:"practice:rerun_terrain/1_0_1"}
setblock ~-69 ~-1 ~-67 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:22, sizeY:21, sizeZ:20, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~-46 ~-2 ~-67 ~-46 ~-1 ~-67 redstone_block
fill ~-46 ~-2 ~-47 ~-46 ~-1 ~-47 redstone_block
fill ~-68 ~-2 ~-47 ~-68 ~-1 ~-47 redstone_block
fill ~-68 ~-2 ~-67 ~-68 ~-1 ~-67 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~-47 254 ~-67 ~-46 255 ~-67 ~-47 ~-2 ~-67 replace
clone ~-47 254 ~-47 ~-46 255 ~-47 ~-47 ~-2 ~-47 replace
clone ~-69 254 ~-47 ~-68 255 ~-47 ~-69 ~-2 ~-47 replace
clone ~-69 254 ~-67 ~-68 255 ~-67 ~-69 ~-2 ~-67 replace

# Replace the blocks at height limit with air
fill ~-47 254 ~-67 ~-46 255 ~-67 air
fill ~-47 254 ~-47 ~-46 255 ~-47 air
fill ~-69 254 ~-47 ~-68 255 ~-47 air
fill ~-69 254 ~-67 ~-68 255 ~-67 air
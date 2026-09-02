# Clone existing terrain blocks to height limit
clone ~1 ~-2 ~-47 ~0 ~-1 ~-47 ~0 254 ~-47
clone ~49 ~-2 ~-47 ~48 ~-1 ~-47 ~48 254 ~-47
clone ~1 ~-2 ~-83 ~0 ~-1 ~-83 ~0 254 ~-83
clone ~49 ~-2 ~-83 ~48 ~-1 ~-83 ~48 254 ~-83

# Create structure blocks to save terrain
setblock ~0 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~0 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~48 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:22, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_1"}
setblock ~48 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:22, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_1"}

setblock ~0 ~-2 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/1_0_0"}
setblock ~0 ~-1 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:36, name:"practice:rerun_terrain/1_1_0"}

setblock ~48 ~-2 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:22, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/1_0_1"}
setblock ~48 ~-1 ~-83 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:22, sizeY:21, sizeZ:36, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~1 ~-2 ~-47 ~1 ~-1 ~-47 redstone_block
fill ~49 ~-2 ~-47 ~49 ~-1 ~-47 redstone_block
fill ~1 ~-2 ~-83 ~1 ~-1 ~-83 redstone_block
fill ~49 ~-2 ~-83 ~49 ~-1 ~-83 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~0 254 ~-47 ~1 255 ~-47 ~0 ~-2 ~-47 replace
clone ~48 254 ~-47 ~49 255 ~-47 ~48 ~-2 ~-47 replace
clone ~0 254 ~-83 ~1 255 ~-83 ~0 ~-2 ~-83 replace
clone ~48 254 ~-83 ~49 255 ~-83 ~48 ~-2 ~-83 replace

# Replace the blocks at height limit with air
fill ~0 254 ~-47 ~1 255 ~-47 air
fill ~48 254 ~-47 ~49 255 ~-47 air
fill ~0 254 ~-83 ~1 255 ~-82 air
fill ~48 254 ~-83 ~49 255 ~-82 air
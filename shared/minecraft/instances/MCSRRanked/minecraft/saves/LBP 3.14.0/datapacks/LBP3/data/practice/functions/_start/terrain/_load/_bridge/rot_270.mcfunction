# Clone existing terrain blocks to height limit
clone ~1 ~-2 ~-47 ~0 ~-1 ~-47 ~0 254 ~-47
clone ~49 ~-2 ~-47 ~48 ~-1 ~-47 ~48 254 ~-47
clone ~1 ~-2 ~-74 ~0 ~-1 ~-74 ~0 254 ~-74
clone ~49 ~-2 ~-74 ~48 ~-1 ~-74 ~48 254 ~-74

# Create structure blocks to save terrain
setblock ~0 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~0 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~48 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:36, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_1"}
setblock ~48 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:36, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/0_1_1"}

setblock ~0 ~-2 ~-74 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:27, name:"practice:rerun_terrain/1_0_0"}
setblock ~0 ~-1 ~-74 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:27, name:"practice:rerun_terrain/1_1_0"}

setblock ~48 ~-2 ~-74 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:36, sizeY:47, sizeZ:27, name:"practice:rerun_terrain/1_0_1"}
setblock ~48 ~-1 ~-74 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:36, sizeY:30, sizeZ:27, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~1 ~-2 ~-47 ~1 ~-1 ~-47 redstone_block
fill ~49 ~-2 ~-47 ~49 ~-1 ~-47 redstone_block
fill ~1 ~-2 ~-74 ~1 ~-1 ~-74 redstone_block
fill ~49 ~-2 ~-74 ~49 ~-1 ~-74 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~0 254 ~-47 ~1 255 ~-47 ~0 ~-2 ~-47 replace
clone ~48 254 ~-47 ~49 255 ~-47 ~48 ~-2 ~-47 replace
clone ~0 254 ~-74 ~1 255 ~-74 ~0 ~-2 ~-74 replace
clone ~48 254 ~-74 ~49 255 ~-74 ~48 ~-2 ~-74 replace

# Replace the blocks at height limit with air
fill ~0 254 ~-47 ~1 255 ~-47 air
fill ~48 254 ~-47 ~49 255 ~-47 air
fill ~0 254 ~-74 ~1 255 ~-73 air
fill ~48 254 ~-74 ~49 255 ~-73 air
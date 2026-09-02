# Clone existing terrain blocks to height limit
clone ~1 ~-2 ~-47 ~0 ~-1 ~-47 ~0 254 ~-47
clone ~49 ~-2 ~-47 ~48 ~-1 ~-47 ~48 254 ~-47
clone ~1 ~-2 ~-69 ~0 ~-1 ~-69 ~0 254 ~-69
clone ~49 ~-2 ~-69 ~48 ~-1 ~-69 ~48 254 ~-69

# Create structure blocks to save terrain
setblock ~0 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~0 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~48 ~-2 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:20, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_1"}
setblock ~48 ~-1 ~-47 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:20, sizeY:21, sizeZ:48, name:"practice:rerun_terrain/0_1_1"}

setblock ~0 ~-2 ~-69 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:22, name:"practice:rerun_terrain/1_0_0"}
setblock ~0 ~-1 ~-69 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:48, sizeY:21, sizeZ:22, name:"practice:rerun_terrain/1_1_0"}

setblock ~48 ~-2 ~-69 structure_block{mode:"LOAD", ignoreEntities:0b, posY:2, sizeX:20, sizeY:47, sizeZ:22, name:"practice:rerun_terrain/1_0_1"}
setblock ~48 ~-1 ~-69 structure_block{mode:"LOAD", ignoreEntities:0b, posY:48, sizeX:20, sizeY:21, sizeZ:22, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~1 ~-2 ~-47 ~1 ~-1 ~-47 redstone_block
fill ~49 ~-2 ~-47 ~49 ~-1 ~-47 redstone_block
fill ~1 ~-2 ~-69 ~1 ~-1 ~-69 redstone_block
fill ~49 ~-2 ~-69 ~49 ~-1 ~-69 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~0 254 ~-47 ~1 255 ~-47 ~0 ~-2 ~-47 replace
clone ~48 254 ~-47 ~49 255 ~-47 ~48 ~-2 ~-47 replace
clone ~0 254 ~-69 ~1 255 ~-69 ~0 ~-2 ~-69 replace
clone ~48 254 ~-69 ~49 255 ~-69 ~48 ~-2 ~-69 replace

# Replace the blocks at height limit with air
fill ~0 254 ~-47 ~1 255 ~-47 air
fill ~48 254 ~-47 ~49 255 ~-47 air
fill ~0 254 ~-69 ~1 255 ~-68 air
fill ~48 254 ~-69 ~49 255 ~-68 air
# Clone existing terrain blocks to height limit
clone ~1 ~-2 ~0 ~0 ~-1 ~0 ~0 254 ~0
clone ~1 ~-2 ~48 ~0 ~-1 ~48 ~0 254 ~48
clone ~49 ~-2 ~0 ~48 ~-1 ~0 ~48 254 ~0
clone ~49 ~-2 ~48 ~48 ~-1 ~48 ~48 254 ~48

# Create structure blocks to save terrain
setblock ~0 ~-2 ~0 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~0 ~-1 ~0 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~0 ~-2 ~48 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/0_0_1"}
setblock ~0 ~-1 ~48 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:30, sizeZ:36, name:"practice:rerun_terrain/0_1_1"}

setblock ~48 ~-2 ~0 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:27, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/1_0_0"}
setblock ~48 ~-1 ~0 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:27, sizeY:30, sizeZ:48, name:"practice:rerun_terrain/1_1_0"}

setblock ~48 ~-2 ~48 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:27, sizeY:47, sizeZ:36, name:"practice:rerun_terrain/1_0_1"}
setblock ~48 ~-1 ~48 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:27, sizeY:30, sizeZ:36, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~1 ~-2 ~0 ~1 ~-1 ~0 redstone_block
fill ~1 ~-2 ~48 ~1 ~-1 ~48 redstone_block
fill ~49 ~-2 ~0 ~49 ~-1 ~0 redstone_block
fill ~49 ~-2 ~48 ~49 ~-1 ~48 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~0 254 ~0 ~1 255 ~0 ~0 ~-2 ~0 replace
clone ~0 254 ~48 ~1 255 ~48 ~0 ~-2 ~48 replace
clone ~48 254 ~0 ~49 255 ~0 ~48 ~-2 ~0 replace
clone ~48 254 ~48 ~49 255 ~48 ~48 ~-2 ~48 replace

# Replace the blocks at height limit with air
fill ~0 254 ~0 ~1 255 ~0 air
fill ~0 254 ~48 ~1 255 ~48 air
fill ~48 254 ~0 ~49 255 ~0 air
fill ~48 254 ~48 ~49 255 ~48 air
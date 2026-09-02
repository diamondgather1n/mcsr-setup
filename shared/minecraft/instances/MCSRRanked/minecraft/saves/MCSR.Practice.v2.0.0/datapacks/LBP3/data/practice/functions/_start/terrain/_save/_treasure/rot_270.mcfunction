# Clone existing terrain blocks to height limit
clone ~1 ~-2 ~-47 ~0 ~-1 ~-47 ~0 254 ~-47
clone ~49 ~-2 ~-47 ~48 ~-1 ~-47 ~48 254 ~-47
clone ~1 ~-2 ~-59 ~0 ~-1 ~-59 ~0 254 ~-59
clone ~49 ~-2 ~-59 ~48 ~-1 ~-59 ~48 254 ~-59

# Create structure blocks to save terrain
setblock ~0 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_0"}
setblock ~0 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:35, sizeZ:48, name:"practice:rerun_terrain/0_1_0"}

setblock ~48 ~-2 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:42, sizeY:47, sizeZ:48, name:"practice:rerun_terrain/0_0_1"}
setblock ~48 ~-1 ~-47 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:42, sizeY:35, sizeZ:48, name:"practice:rerun_terrain/0_1_1"}

setblock ~0 ~-2 ~-59 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:48, sizeY:47, sizeZ:12, name:"practice:rerun_terrain/1_0_0"}
setblock ~0 ~-1 ~-59 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:48, sizeY:35, sizeZ:12, name:"practice:rerun_terrain/1_1_0"}

setblock ~48 ~-2 ~-59 structure_block{mode:"SAVE", ignoreEntities:0b, posY:2, sizeX:42, sizeY:47, sizeZ:12, name:"practice:rerun_terrain/1_0_1"}
setblock ~48 ~-1 ~-59 structure_block{mode:"SAVE", ignoreEntities:0b, posY:48, sizeX:42, sizeY:35, sizeZ:12, name:"practice:rerun_terrain/1_1_1"}

# Activate structure blocks to save terrain to memory
fill ~1 ~-2 ~-47 ~1 ~-1 ~-47 redstone_block
fill ~49 ~-2 ~-47 ~49 ~-1 ~-47 redstone_block
fill ~1 ~-2 ~-59 ~1 ~-1 ~-59 redstone_block
fill ~49 ~-2 ~-59 ~49 ~-1 ~-59 redstone_block

# Clone terrain back from height limit to replace the structure blocks and redstone blocks
clone ~0 254 ~-47 ~1 255 ~-47 ~0 ~-2 ~-47 replace
clone ~48 254 ~-47 ~49 255 ~-47 ~48 ~-2 ~-47 replace
clone ~0 254 ~-59 ~1 255 ~-59 ~0 ~-2 ~-59 replace
clone ~48 254 ~-59 ~49 255 ~-59 ~48 ~-2 ~-59 replace

# Replace the blocks at height limit with air
fill ~0 254 ~-47 ~1 255 ~-47 air
fill ~48 254 ~-47 ~49 255 ~-47 air
fill ~0 254 ~-59 ~1 255 ~-58 air
fill ~48 254 ~-59 ~49 255 ~-58 air
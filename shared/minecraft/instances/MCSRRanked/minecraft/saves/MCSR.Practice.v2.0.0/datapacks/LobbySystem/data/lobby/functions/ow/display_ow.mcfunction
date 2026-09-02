setblock -147 95 48 minecraft:structure_block

playsound minecraft:block.comparator.click player @a[tag=sound] ~ ~ ~ 0.8

data merge block -147 95 48 {mode:"LOAD",name:"ow_display",posX:-6,posY:-5,posZ:0,sizeX:5,sizeY:4,sizeZ:1}

setblock -146 95 48 minecraft:redstone_block
setblock -146 95 48 minecraft:air

setblock -147 95 48 minecraft:air
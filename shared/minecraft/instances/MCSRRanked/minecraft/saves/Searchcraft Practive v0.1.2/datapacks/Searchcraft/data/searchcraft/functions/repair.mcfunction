setblock 0 59 0 minecraft:structure_block[mode=load]{ignoreEntities:1b,mode:"LOAD",posX:-4,posY:1,posZ:-4,name:"searchcraft:map",showboundingbox:0b}
setblock 0 58 0 minecraft:redstone_block
fill 0 58 0 0 59 0 air
function searchcraft:init
scoreboard players reset * repair
kill @e[type=item]
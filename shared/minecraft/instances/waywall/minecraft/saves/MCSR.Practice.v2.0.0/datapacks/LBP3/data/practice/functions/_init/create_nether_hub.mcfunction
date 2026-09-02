execute in the_nether unless block 100 110 0 white_concrete run setblock 100 111 0 structure_block{ignoreEntities:0b,mode:"LOAD",name:"practice:hub2",posY:-26}

execute in the_nether unless block 100 110 0 white_concrete run setblock 100 112 0 redstone_block

execute in the_nether unless block 100 110 0 white_concrete run schedule function practice:_init/create_nether_hub

clone ~ ~ ~ ~ ~1 ~ ~ 254 ~
setblock ~ ~ ~ structure_block{mode:"LOAD", rotation:"COUNTERCLOCKWISE_90", name:"sp.fortress:corridor/right_turn"}
setblock ~ ~1 ~ redstone_block
setblock ~ ~ ~ nether_bricks
setblock ~ ~1 ~ nether_bricks
fill ~ 254 ~ ~ 255 ~ air

execute positioned ~1 ~2 ~-3 run function sp.fortress:internal/update_chest

execute positioned ~ ~-1 ~ run function sp.fortress:internal/fill_support
execute positioned ~1 ~-1 ~ run function sp.fortress:internal/fill_support
execute positioned ~2 ~-1 ~ run function sp.fortress:internal/fill_support
execute positioned ~3 ~-1 ~ run function sp.fortress:internal/fill_support
execute positioned ~4 ~-1 ~ run function sp.fortress:internal/fill_support
execute positioned ~ ~-1 ~-1 run function sp.fortress:internal/fill_support
execute positioned ~1 ~-1 ~-1 run function sp.fortress:internal/fill_support
execute positioned ~2 ~-1 ~-1 run function sp.fortress:internal/fill_support
execute positioned ~3 ~-1 ~-1 run function sp.fortress:internal/fill_support
execute positioned ~4 ~-1 ~-1 run function sp.fortress:internal/fill_support
execute positioned ~ ~-1 ~-2 run function sp.fortress:internal/fill_support
execute positioned ~1 ~-1 ~-2 run function sp.fortress:internal/fill_support
execute positioned ~2 ~-1 ~-2 run function sp.fortress:internal/fill_support
execute positioned ~3 ~-1 ~-2 run function sp.fortress:internal/fill_support
execute positioned ~4 ~-1 ~-2 run function sp.fortress:internal/fill_support
execute positioned ~ ~-1 ~-3 run function sp.fortress:internal/fill_support
execute positioned ~1 ~-1 ~-3 run function sp.fortress:internal/fill_support
execute positioned ~2 ~-1 ~-3 run function sp.fortress:internal/fill_support
execute positioned ~3 ~-1 ~-3 run function sp.fortress:internal/fill_support
execute positioned ~4 ~-1 ~-3 run function sp.fortress:internal/fill_support
execute positioned ~ ~-1 ~-4 run function sp.fortress:internal/fill_support
execute positioned ~1 ~-1 ~-4 run function sp.fortress:internal/fill_support
execute positioned ~2 ~-1 ~-4 run function sp.fortress:internal/fill_support
execute positioned ~3 ~-1 ~-4 run function sp.fortress:internal/fill_support
execute positioned ~4 ~-1 ~-4 run function sp.fortress:internal/fill_support

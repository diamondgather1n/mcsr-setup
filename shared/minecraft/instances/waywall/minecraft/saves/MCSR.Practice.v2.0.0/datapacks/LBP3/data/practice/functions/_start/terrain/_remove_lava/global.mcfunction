fill ~ ~ ~ ~ ~ ~ air replace lava

execute positioned ~ ~1 ~ if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
execute positioned ~ ~-1 ~ if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
execute positioned ~1 ~ ~ if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
execute positioned ~-1 ~ ~ if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
execute positioned ~ ~ ~1 if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
execute positioned ~ ~ ~-1 if predicate practice:drainable run function practice:_start/terrain/_remove_lava/global
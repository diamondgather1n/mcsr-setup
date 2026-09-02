function bastionbuilder:internal/pre_place

execute if score bastion_type bastion.temp matches 1 align xyz positioned ~0.5 ~ ~0.5 run function bastionbuilder:internal/bridge
execute if score bastion_type bastion.temp matches 2 align xyz positioned ~0.5 ~ ~0.5 run function bastionbuilder:internal/hoglin_stable
execute if score bastion_type bastion.temp matches 3 align xyz positioned ~0.5 ~ ~0.5 run function bastionbuilder:internal/treasure
execute if score bastion_type bastion.temp matches 4 align xyz positioned ~0.5 ~ ~0.5 run function bastionbuilder:internal/units

function bastionbuilder:internal/post_place
# generate_village.mcfunction
# This function randomly chooses a village layout (1-3) and generates the village

# Run the RNG function to choose a layout
function practice:rng

# Layout 1
execute if score @p randomTemp matches 1 run function practice:village/layout_1

# Layout 2
execute if score @p randomTemp matches 2 run function practice:village/layout_2

# Layout 3
execute if score @p randomTemp matches 3 run function practice:village/layout_3

data modify storage searchcraft:recipes recipes_enabled set value []
data modify storage searchcraft:recipes recipes_enabled append from storage searchcraft:recipes recipes[{enabled:1b}]

execute store result score mod rng run data get storage searchcraft:recipes recipes_enabled
function searchcraft:random/generate
function searchcraft:recipes/set_selected
function searchcraft:recipes/load
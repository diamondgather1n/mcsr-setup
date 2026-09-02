# increment timer
execute if score active timer matches 1 run scoreboard players add timer timer 1

# display timer in actionbar
function searchcraft:timer/calculate_units
function searchcraft:timer/parser

title @a actionbar [{"nbt":"time_string","storage":"searchcraft:timeparser","interpret":true}]
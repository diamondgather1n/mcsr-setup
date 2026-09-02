# increment timer
execute if score active timer matches 1 run scoreboard players add timer timer 1

# display timer in actionbar
function lobby:timer/calculate_units
function lobby:timer/parser

title @a actionbar [{"nbt":"time_string","storage":"lobby:timeparser","interpret":true}]
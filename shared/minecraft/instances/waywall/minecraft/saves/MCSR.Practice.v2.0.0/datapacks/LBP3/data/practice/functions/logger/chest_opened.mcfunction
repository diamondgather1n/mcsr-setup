function practice:logger/update_timestamp

tellraw @a ["[",{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true},".",{"nbt":"miliseconds","storage":"timer","interpret":true},"] ",{"text":"Chest opened","color":"#14d3e0"}]
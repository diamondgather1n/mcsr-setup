function practice:logger/update_timestamp

tellraw @a ["[",{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true},".",{"nbt":"miliseconds","storage":"timer","interpret":true},"] ",{"text":"Gold block mined","color":"#35de1f"}]
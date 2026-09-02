tellraw @a [{"text":"Do you really want to delete this recipe? ","color":"yellow"},{"text":"\n   [Delete]","color":"red","clickEvent":{"action":"run_command","value":"/function searchcraft:gui/configuration/delete"}},{"text":"   [Cancel]","color":"gray","clickEvent":{"action":"run_command","value":"/function searchcraft:gui/configuration/cancel_delete"}}]

setblock -65 63 377 air
setblock -65 63 377 chest[type=right,facing=east]
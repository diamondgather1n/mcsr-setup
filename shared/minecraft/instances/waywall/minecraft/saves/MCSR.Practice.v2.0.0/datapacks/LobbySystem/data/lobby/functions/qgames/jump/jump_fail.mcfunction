playsound minecraft:block.note_block.bass ambient @a ~ ~ ~ 1 1

scoreboard players operation @p jumpTemp = @p jumpCurrent

execute if score @p jumpTemp > @p jumpPb run playsound minecraft:entity.player.levelup ambient @p ~ ~ ~ 0.6 1

execute if score @p jumpTemp <= @p jumpPb run title @p actionbar {"text":"× Failed ×","bold":true,"color":"#DE2A2C"}
execute if score @p jumpTemp > @p jumpPb run data merge block 173 72 270 {Text1:'{"text":""}',Text2:'["",{"text":"PB: ","bold":true,"color":"#FFE023"},{"score":{"name":"@p","objective":"jumpTemp"},"bold":true,"color":"#FFE023"}]'}
execute if score @p jumpTemp > @p jumpPb run title @a actionbar ["",{"text":"NEW PB: ","color":"#FFC53C","bold":"true"},{"score":{"name":"@p","objective":"jumpTemp"},"bold":"true","color":"#FFC53C"}]

execute if score @p jumpCurrent > @p jumpPb run scoreboard players operation @p jumpPb = @p jumpCurrent

scoreboard players set @p jumpCurrent 0

function lobby:qgames/jump/jump_start

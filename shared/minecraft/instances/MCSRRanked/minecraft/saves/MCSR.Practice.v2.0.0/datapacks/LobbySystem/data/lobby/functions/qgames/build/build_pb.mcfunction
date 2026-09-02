scoreboard players operation @p buildTemp = @p buildScore

execute at @a[tag=sound] as @a[tag=sound] if score @p buildTemp > @p buildPb run schedule function lobby:qgames/build/pb_sound 2t

execute if score @p buildTemp <= @p buildPb run title @p actionbar {"text":"× Failed ×","bold":true,"color":"#DE2A2C"}
execute if score @p buildTemp > @p buildPb run data merge block 173 72 274 {Text1:'{"text":""}',Text2:'["",{"text":"PB: ","bold":true,"color":"#FFE023"},{"score":{"name":"@p","objective":"buildTemp"},"bold":true,"color":"#FFE023"}]'}
execute if score @p buildTemp > @p buildPb run title @a actionbar ["",{"text":"NEW PB: ","color":"#FFC53C","bold":"true"},{"score":{"name":"@p","objective":"buildTemp"},"bold":"true","color":"#FFC53C"}]

execute if score @p buildScore > @p buildPb run scoreboard players operation @p buildPb = @p buildScore

scoreboard players set @p buildScore 0


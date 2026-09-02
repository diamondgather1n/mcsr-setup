scoreboard players set max bastion.rng 4
function bastionbuilder:internal/utils/rng/new_int

execute if score out bastion.rng matches 1 run summon hoglin ~0.5 ~ ~-0.5 {NoAI: 1, Silent: 1, PersistenceRequired: 1, CannotBeHunted: 1, Tags:["bastion_mob"], Age: -24000}
execute if score out bastion.rng matches 2 run summon hoglin ~0.5 ~ ~0.5 {NoAI: 1, Silent: 1, PersistenceRequired: 1, CannotBeHunted: 1, Tags:["bastion_mob"], Age: -24000}
execute if score out bastion.rng matches 3 run summon hoglin ~-0.5 ~ ~0.5 {NoAI: 1, Silent: 1, PersistenceRequired: 1, CannotBeHunted: 1, Tags:["bastion_mob"], Age: -24000}
execute if score out bastion.rng matches 4 run summon hoglin ~-0.5 ~ ~-0.5 {NoAI: 1, Silent: 1, PersistenceRequired: 1, CannotBeHunted: 1, Tags:["bastion_mob"], Age: -24000}
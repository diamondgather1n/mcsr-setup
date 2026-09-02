scoreboard objectives add settings dummy
execute unless score bastion settings = bastion settings run scoreboard players set bastion settings 0
execute unless score terrain settings = terrain settings run scoreboard players set terrain settings 0
execute unless score natural_mobs settings = natural_mobs settings run scoreboard players set natural_mobs settings 1
execute unless score piedar settings = piedar settings run scoreboard players set piedar settings 0
execute unless score rerun_terrain settings = rerun_terrain settings run scoreboard players set rerun_terrain settings 0
execute unless score spawnpoint_bridge settings = spawnpoint_bridge settings run scoreboard players set spawnpoint_bridge settings 0
execute unless score spawnpoint_stables settings = spawnpoint_stables settings run scoreboard players set spawnpoint_stables settings 0
execute unless score spawnpoint_treasure settings = spawnpoint_treasure settings run scoreboard players set spawnpoint_treasure settings 0
execute unless score spawnpoint_units settings = spawnpoint_units settings run scoreboard players set spawnpoint_units settings 0
execute unless score spawnpoint_random settings = spawnpoint_random settings run scoreboard players set spawnpoint_random settings 0
execute unless score tick_warp settings = tick_warp settings run scoreboard players set tick_warp settings 0
execute unless score spawnpoint_dist settings = spawnpoint_dist settings run scoreboard players set spawnpoint_dist settings 0
execute unless score practice_floor settings = practice_floor settings run scoreboard players set practice_floor settings 0
execute unless score units_lava settings = units_lava settings run scoreboard players set units_lava settings 2

scoreboard objectives add practice dummy
execute unless score has_carpet practice = has_carpet practice run scoreboard players set has_carpet practice 0
execute store success score has_carpet practice run function practice:check_for_carpet

scoreboard objectives add dropped_dia_pick minecraft.dropped:minecraft.diamond_pickaxe
scoreboard objectives add dropped_iro_pick minecraft.dropped:minecraft.iron_pickaxe
scoreboard objectives add dropped_gol_pick minecraft.dropped:minecraft.golden_pickaxe
scoreboard objectives add dropped_sto_pick minecraft.dropped:minecraft.stone_pickaxe
scoreboard objectives add dropped_woo_pick minecraft.dropped:minecraft.wooden_pickaxe
scoreboard objectives add dropped_net_pick minecraft.dropped:minecraft.netherite_pickaxe
scoreboard objectives add deaths deathCount

scoreboard objectives add playerpos dummy
scoreboard objectives add jumps minecraft.custom:jump

# Instantiate current run info scores
scoreboard objectives add practice.info dummy "\u00A7bRun Info"
execute unless score #gold practice.info = #gold practice.info run scoreboard players set #gold practice.info 0
execute unless score Barters practice.info = Barters practice.info run scoreboard players set Barters practice.info 0
execute unless score Piglins practice.info = Piglins practice.info run scoreboard players set Piglins practice.info 0
scoreboard players set #10 practice.info 10
scoreboard objectives add damage_taken minecraft.custom:minecraft.damage_taken
scoreboard objectives remove current_barter
scoreboard objectives add current_barter dummy

# Create scoreboards for run info
scoreboard objectives add practice.gold dummy
scoreboard objectives add practice.barters dummy
scoreboard objectives add practice.piglins dummy

# Create hub if it doesn't exist
execute in the_nether run forceload remove all
execute in the_nether run forceload add 100 0
function practice:_init/create_nether_hub

# Set the players spawnpoint to the hub
function practice:_init/set_player_spawnpoint

# Teleport the player to the hub
function practice:_init/fully_reset_player
effect give @a saturation 1 20 true

# Teams
team add no_collison
team modify no_collison collisionRule never
team empty no_collison

# Saturation reset mode
execute unless score sat_reset practice = sat_reset practice run scoreboard players set sat_reset practice 0
execute if score has_carpet practice matches 0 run scoreboard players set sat_reset practice 0

# Enable keepInventory
gamerule keepInventory true

# Bastion rotation mode
execute unless score bastion_rotation practice = bastion_rotation practice run scoreboard players set bastion_rotation practice 0

# Unschedule reset check for warping
schedule clear practice:_start/wait_for_movement/_warp/reset_check

# Piedar distance option
execute unless score piedar_dist settings = piedar_dist settings run scoreboard players set piedar_dist settings 3

# Logger
execute unless score logger practice = logger practice run scoreboard players set logger practice 0
scoreboard objectives add open_chest minecraft.custom:minecraft.open_chest
scoreboard objectives add gold_mined minecraft.mined:minecraft.gold_block

# User interface
execute unless score ui practice = ui practice run scoreboard players set ui practice 1

# ID piglins
execute unless score id_piglins bastion.settings = id_piglins bastion.settings run scoreboard players set id_piglins bastion.settings 0

scoreboard players set running bastion.temp 0
scoreboard players add bridge_lava_fix bastion.settings 1
execute if score bridge_lava_fix bastion.settings matches 2.. run scoreboard players set bridge_lava_fix bastion.settings 0

schedule function practice:commands/messages/bridge_lava_fix 1t
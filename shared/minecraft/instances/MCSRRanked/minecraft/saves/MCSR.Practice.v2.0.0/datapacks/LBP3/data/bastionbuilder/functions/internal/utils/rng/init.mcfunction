scoreboard objectives add bastion.rng dummy "\u00A7aBastionRNG"

scoreboard players set $32768 bastion.rng 32768
scoreboard players set $65536 bastion.rng 65536
scoreboard players set $1103515245 bastion.rng 1103515245
scoreboard players set $-2147483648 bastion.rng -2147483648

function bastionbuilder:internal/utils/rng/generate_seed
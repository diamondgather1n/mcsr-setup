scoreboard players set r randomTemp 0

execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 1
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 2
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 4
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 8
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 16
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 32
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 64
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 128
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 256
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 512
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 1024
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 2048
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 4096
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 8192
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 16384
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 32768
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 65536
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 131072
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 262144
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 524288
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 1048576
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 2097152
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 4194304
execute if predicate lobby:rand_50 run scoreboard players add r randomTemp 8388608

scoreboard players operation r randomTemp %= mod randomTemp

scoreboard players add r randomTemp 1
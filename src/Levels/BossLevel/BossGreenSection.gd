extends "res://src/Levels/BossLevel/BossSection.gd"

onready var green_enemy_prefab = preload("res://src/Levels/BossLevel/GreenEnemy2.tscn")
onready var red_enemy_prefab = preload("res://src/Levels/BossLevel/RedEnemy2.tscn")
onready var blue_enemy_prefab = preload("res://src/Levels/BossLevel/BlueEnemy2.tscn")
onready var yellow_enemy_prefab = preload("res://src/Levels/BossLevel/YellowEnemy2.tscn")


func _on_SpawnTimer_timeout():
	var color_picker = GlobalVariables.rng.randi() % 4
	var enemy = null
	if color_picker == 0:
		enemy = green_enemy_prefab.instance()
	elif color_picker == 1:
		enemy = red_enemy_prefab.instance()
	elif color_picker == 2:
		enemy = blue_enemy_prefab.instance()
	elif color_picker == 3:
		enemy = yellow_enemy_prefab.instance()
	get_parent().add_child(enemy)
	enemy.pause_mode = Node.PAUSE_MODE_STOP
	enemy.position = position

extends Node2D

onready var asteroid_prefab = preload("res://src/Actors/Asteroid.tscn")
onready var enemy_prefab = preload("res://src/Actors/Enemy1.tscn")

func _ready():
	get_node("ParallaxBackground/ParallaxLayer2/LargeSun").position = Vector2(GlobalVariables.rng.randf() * 2000 - 1000, GlobalVariables.rng.randf() * 2000 - 1000)
	
	var asteroid_num = GlobalVariables.rng.randi() % 3 + 2
	var enemy_num = GlobalVariables.rng.randi() % 7 + 3
	
	for i in asteroid_num:
		var asteroid = asteroid_prefab.instance()
		add_child(asteroid)
		asteroid.position = Vector2(GlobalVariables.rng.randf() * 1000 - 100, GlobalVariables.rng.randf() * 1000 - 100)
	
	for i in enemy_num:
		var enemy = enemy_prefab.instance()
		add_child(enemy)
		enemy.position = Vector2(GlobalVariables.rng.randf() * 1000 - 100, GlobalVariables.rng.randf() * 1000 - 100)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

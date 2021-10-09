extends Node2D

onready var asteroid_prefab = preload("res://src/Actors/Asteroid.tscn")
onready var enemy_prefab = preload("res://src/Actors/Enemy1.tscn")
onready var moon_prefab = preload("res://Assets/LargeMoon.png")

func _ready():
	var random_parallax = GlobalVariables.rng.randi() % 2
	if random_parallax == 1:
		get_node("ParallaxBackground/ParallaxLayer2/LargeSun").texture = moon_prefab
	
	get_node("ParallaxBackground/ParallaxLayer2/LargeSun").position = Vector2(GlobalVariables.rng.randf() * 2000 - 1000, GlobalVariables.rng.randf() * 1000 - 500)
	
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

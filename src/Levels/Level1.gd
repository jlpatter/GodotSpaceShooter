extends Node2D

onready var asteroid_prefab = preload("res://src/Actors/Asteroid.tscn")
onready var arrow_prefab = preload("res://src/Misc/Arrow.tscn")
onready var enemy_prefab = preload("res://src/Actors/Enemy1.tscn")
onready var moon_prefab = preload("res://Assets/LargeMoon.png")
onready var ice_prefab = preload("res://Assets/LargeIce.png")
onready var green_gem_prefab = preload("res://src/Actors/GreenGem.tscn")
onready var red_gem_prefab = preload("res://src/Actors/RedGem.tscn")
onready var blue_gem_prefab = preload("res://src/Actors/BlueGem.tscn")
onready var yellow_gem_prefab = preload("res://src/Actors/YellowGem.tscn")


func _ready():
	var random_parallax = GlobalVariables.rng.randi() % 3
	if random_parallax == 1:
		get_node("ParallaxBackground/ParallaxLayer2/LargeSun").texture = moon_prefab
	elif random_parallax == 2:
		get_node("ParallaxBackground/ParallaxLayer2/LargeSun").texture = ice_prefab
	
	get_node("ParallaxBackground/ParallaxLayer2/LargeSun").position = Vector2(GlobalVariables.rng.randf() * 2000 - 1000, GlobalVariables.rng.randf() * 1000 - 500)
	
	var asteroid_num = GlobalVariables.rng.randi() % 3 + 2
	var enemy_num = GlobalVariables.rng.randi() % 7 + 3
	
	for i in asteroid_num:
		var asteroid = asteroid_prefab.instance()
		var asteroid_arrow = arrow_prefab.instance()
		add_child(asteroid)
		add_child(asteroid_arrow)
		asteroid_arrow.set_target(asteroid)
		asteroid.position = Vector2(GlobalVariables.rng.randf() * 1000 - 100, GlobalVariables.rng.randf() * 1000 - 100)
	
	for i in enemy_num:
		var enemy = enemy_prefab.instance()
		add_child(enemy)
		enemy.position = Vector2(GlobalVariables.rng.randf() * 1000 - 100, GlobalVariables.rng.randf() * 1000 - 100)
	
	if MapVariables.current_color == "":
		MapVariables.current_color = "Green"
	
	if GlobalVariables.rng.randi() % 10 == 0:
		if MapVariables.current_color == "Green":
			add_gem(green_gem_prefab, Color.green)
		elif MapVariables.current_color == "Red":
			add_gem(red_gem_prefab, Color.red)
		elif MapVariables.current_color == "Blue":
			add_gem(blue_gem_prefab, Color.blue)
		elif MapVariables.current_color == "Yellow":
			add_gem(yellow_gem_prefab, Color.yellow)

func add_gem(var gem_prefab, var arrow_color):
	var gem = gem_prefab.instance()
	var gem_arrow = arrow_prefab.instance()
	add_child(gem)
	add_child(gem_arrow)
	gem.position = Vector2(GlobalVariables.rng.randf() * 1000 - 100, GlobalVariables.rng.randf() * 1000 - 100)
	gem_arrow.set_target(gem)
	gem_arrow.color = arrow_color

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

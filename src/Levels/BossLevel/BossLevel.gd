extends Node2D

var timer = 0.5

onready var black_cube_prefab = preload("res://src/Levels/BossLevel/BlackCube.tscn")
onready var black_pyramid_prefab = preload("res://src/Levels/BossLevel/BlackPyramid.tscn")
onready var black_sphere_prefab = preload("res://src/Levels/BossLevel/BlackSphere.tscn")

func _ready():
	$BossGreenSection.position = Vector2(get_viewport().size.x * (4.0 / 5.0), get_node("BossGreenSection/BossGreenSection").texture.get_height())
	$BossRedSection.position = Vector2(get_viewport().size.x * (3.0 / 5.0), get_node("BossRedSection/BossRedSection").texture.get_height())
	$BossBlueSection.position = Vector2(get_viewport().size.x * (2.0 / 5.0), get_node("BossBlueSection/BossBlueSection").texture.get_height())
	$Player.position = Vector2(get_viewport().size.x / 2.0, get_viewport().size.y - get_node("Player/PlayerShip").texture.get_height())

func _process(delta):
	timer -= delta
	if timer < 0.0:
		var black_object = null
		var object_picker = GlobalVariables.rng.randi() % 3
		if object_picker == 0:
			black_object = black_cube_prefab.instance()
		elif object_picker == 1:
			black_object = black_pyramid_prefab.instance()
		elif object_picker == 2:
			black_object = black_sphere_prefab.instance()
		
		add_child(black_object)
		black_object.position = Vector2(GlobalVariables.rng.randf() * get_viewport().size.x, 0.0)
		
		timer = GlobalVariables.rng.randf() * 0.5

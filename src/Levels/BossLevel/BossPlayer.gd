extends Node2D

const SPEED = 200.0

var health = 100.0

onready var green_bullet_prefab = preload("res://src/Actors/GreenBullet.tscn")

func _physics_process(delta):
	var velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = green_bullet_prefab.instance()
		get_parent().add_child(bullet)
		bullet.position = $BulletSpawn.global_position
		
		var bullet2 = green_bullet_prefab.instance()
		get_parent().add_child(bullet2)
		bullet2.position = $BulletSpawn2.global_position
		
		var bullet3 = green_bullet_prefab.instance()
		get_parent().add_child(bullet3)
		bullet3.position = $BulletSpawn3.global_position
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	position += velocity * SPEED * delta

func increase_health(var amount):
	if health + amount <= 100:
		health += amount
	else:
		health = 100

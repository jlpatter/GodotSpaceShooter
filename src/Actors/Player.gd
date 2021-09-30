extends KinematicBody2D

const SPEED = 10000.0
const ROTATION_SPEED = 2.0

onready var bulletPrefab = preload("res://src/Actors/GreenBullet.tscn")

func _physics_process(delta):
	var rotation_dir = 0.0
	var velocity = Vector2(
		0.0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).rotated(rotation)
	
	if Input.is_action_pressed("move_left"):
		rotation_dir -= 1
	elif Input.is_action_pressed("move_right"):
		rotation_dir += 1
	
	if Input.get_action_strength("move_up"):
		$Fire.show()
	else:
		$Fire.hide()
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bulletPrefab.instance()
		get_parent().add_child(bullet)
		bullet.add_collision_exception_with(self)
		bullet.set_position(position)
		bullet.set_rotation(rotation)
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity * SPEED * delta)

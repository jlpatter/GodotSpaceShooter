extends KinematicBody2D

const SPEED = 500.0
const DECEL_SPEED = 250.0
const ROTATION_SPEED = 2.0

var velocity = Vector2.ZERO
onready var bulletPrefab = preload("res://src/Actors/GreenBullet.tscn")

func _physics_process(delta):
	var rotation_dir = 0.0
	
	if Input.get_action_strength("move_down") or Input.get_action_strength("move_up"):
		velocity += Vector2(
			0.0,
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).rotated(rotation) * SPEED * delta
	else:
		if velocity.length() > Vector2.ZERO.length():
			velocity -= velocity.normalized() * DECEL_SPEED * delta
	
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
		for child_bullet in get_parent().get_node("PlayerBullets").get_children():
			bullet.add_collision_exception_with(child_bullet)
		get_parent().get_node("PlayerBullets").add_child(bullet)
		bullet.add_collision_exception_with(self)
		bullet.set_position($BulletSpawnLocation1.global_position)
		bullet.set_rotation(rotation)
		
		var bullet2 = bulletPrefab.instance()
		for child_bullet in get_parent().get_node("PlayerBullets").get_children():
			bullet2.add_collision_exception_with(child_bullet)
		get_parent().get_node("PlayerBullets").add_child(bullet2)
		bullet2.add_collision_exception_with(self)
		bullet2.set_position($BulletSpawnLocation2.global_position)
		bullet2.set_rotation(rotation)
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity)

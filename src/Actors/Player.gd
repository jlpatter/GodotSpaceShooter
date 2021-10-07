extends KinematicBody2D

const SPEED = 10.0
const DECEL_SPEED = 5.0
const ROTATION_SPEED = 2.0

var velocity = Vector2.ZERO
onready var bullet_prefab = preload("res://src/Actors/GreenBullet.tscn")

func _physics_process(delta):
	var rotation_dir = 0.0
	
	if Input.get_action_strength("move_down") or Input.get_action_strength("move_up"):
		velocity += Vector2(
			0.0,
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).rotated(rotation) * SPEED
	else:
		if velocity.length() > Vector2.ZERO.length():
			velocity -= velocity.normalized() * DECEL_SPEED
			if velocity.length() < Vector2.ONE.length():
				velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		rotation_dir -= 1
	elif Input.is_action_pressed("move_right"):
		rotation_dir += 1
	
	if Input.get_action_strength("move_up"):
		$Fire.show()
		if not $JetSound.playing:
			$JetSound.play()
	else:
		$JetSound.stop()
		$Fire.hide()
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_prefab.instance()
		for child_bullet in get_parent().get_node("PlayerBullets").get_children():
			bullet.add_collision_exception_with(child_bullet)
		get_parent().get_node("PlayerBullets").add_child(bullet)
		bullet.add_collision_exception_with(self)
		bullet.set_position($BulletSpawnLocation1.global_position)
		bullet.set_rotation(rotation)
		bullet.set_speed(velocity.length())
		
		var bullet2 = bullet_prefab.instance()
		for child_bullet in get_parent().get_node("PlayerBullets").get_children():
			bullet2.add_collision_exception_with(child_bullet)
		get_parent().get_node("PlayerBullets").add_child(bullet2)
		bullet2.add_collision_exception_with(self)
		bullet2.set_position($BulletSpawnLocation2.global_position)
		bullet2.set_rotation(rotation)
		bullet2.set_speed(velocity.length())
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity)

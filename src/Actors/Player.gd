extends KinematicBody2D

const SPEED = 10000.0
const ROTATION_SPEED = 2.0

var rotation_dir = 0.0

func _physics_process(delta):
	rotation_dir = 0.0
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
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity * SPEED * delta)

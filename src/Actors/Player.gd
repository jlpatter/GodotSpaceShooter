extends KinematicBody2D

const SPEED = 5000.0

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	move_and_slide(direction * SPEED * delta)

extends KinematicBody2D

const SPEED = 1000.0
const ROTATION_SPEED = 2.0

func _physics_process(delta):
	var dir = Vector2(0.0, -1.0)
	
	rotation += ROTATION_SPEED * delta
	move_and_slide(dir * SPEED * delta)

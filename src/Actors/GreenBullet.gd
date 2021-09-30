extends KinematicBody2D

const SPEED = 10000.0

func _physics_process(delta):
	var dir = Vector2(0.0, -1.0).rotated(rotation)
	move_and_slide(dir * SPEED * delta)

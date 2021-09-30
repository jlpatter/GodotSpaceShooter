extends KinematicBody2D

const SPEED = 30000.0

var delete_time = 10.0

func _physics_process(delta):
	delete_time -= delta
	if delete_time < 0.0:
		queue_free()
	
	var dir = Vector2(0.0, -1.0).rotated(rotation)
	move_and_slide(dir * SPEED * delta)

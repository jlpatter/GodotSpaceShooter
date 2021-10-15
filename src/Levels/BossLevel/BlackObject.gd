extends Node2D

const SPEED = 200.0
const ROTATION_SPEED = 2.0

var timer = 15.0

func _process(delta):
	timer -= delta
	rotation += ROTATION_SPEED * delta
	position += Vector2(0.0, 1.0) * SPEED * delta
	
	if timer < 0.0:
		queue_free()

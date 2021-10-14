extends Node2D

const SPEED = 10.0

func _process(delta):
	position += Vector2(0.0, 1.0) * SPEED * delta

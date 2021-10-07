extends Node2D

const SPEED = 100.0

var timer = 5.0

func _physics_process(delta):
	look_at(get_parent().get_node("Player").position)
	var dir = Vector2(1.0, 0.0).rotated(rotation)
	position += dir * SPEED * delta

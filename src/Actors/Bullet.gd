extends Node2D

class_name Bullet

var SPEED = 300.0

var speed = SPEED
var delete_time = 10.0

func _physics_process(delta):
	delete_time -= delta
	if delete_time < 0.0:
		queue_free()
	
	var dir = Vector2(0.0, -1.0).rotated(rotation)
	position += dir * speed * delta

func set_speed(var ship_speed):
	speed = SPEED + ship_speed

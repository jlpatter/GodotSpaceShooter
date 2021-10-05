extends Node2D

const SPEED = 10.0
const ROTATION_SPEED = 2.0

func _physics_process(delta):
	var dir = Vector2(0.0, -1.0)
	
	rotation += ROTATION_SPEED * delta
	position += dir * SPEED * delta

func _on_Area2D_body_entered(body):
	if "GreenBullet" in body.name:
		body.queue_free()
		queue_free()
	elif "Player" in body.name:
		body.queue_free()
		queue_free()

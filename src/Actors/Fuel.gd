extends Node2D

const ROTATION_SPEED = 5.0


func _physics_process(delta):
	rotation += ROTATION_SPEED * delta


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.increase_fuel(20)
		queue_free()

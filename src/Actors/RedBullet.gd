extends Bullet

const STRENGTH = 25

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.decrease_health(STRENGTH)
		queue_free()

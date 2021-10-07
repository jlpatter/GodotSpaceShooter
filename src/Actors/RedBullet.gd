extends Bullet



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.explode()
		queue_free()

extends Bullet

const STRENGTH = 10

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.decrease_health(STRENGTH)
		queue_free()


func _on_Area2D_area_entered(area):
	if "Player" in area.get_parent().name:
		area.get_parent().decrease_health(STRENGTH)
		queue_free()

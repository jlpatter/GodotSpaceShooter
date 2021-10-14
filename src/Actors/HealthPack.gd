extends Node2D



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.increase_health(25)
		queue_free()


func _on_Area2D_area_entered(area):
	if "Player" in area.get_parent().name:
		area.get_parent().increase_health(25)
		queue_free()

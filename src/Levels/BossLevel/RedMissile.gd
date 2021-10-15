extends Node2D

const SPEED = 200.0

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees += 90
		position += Vector2(0.0, -1.0).rotated(rotation) * SPEED * delta


func _on_Area2D_area_entered(area):
	if "Player" in area.get_parent().name:
		area.get_parent().decrease_health(50)
		queue_free()
	elif "GreenBullet" in area.get_parent().name:
		area.get_parent().queue_free()
		queue_free()

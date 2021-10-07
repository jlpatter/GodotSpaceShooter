extends Node2D

const SPEED = 100.0

var timer = 5.0

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.position)
	var dir = Vector2(1.0, 0.0).rotated(rotation)
	position += dir * SPEED * delta

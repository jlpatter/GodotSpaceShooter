extends "res://src/Levels/BossLevel/BossSection.gd"

func _process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees -= 90

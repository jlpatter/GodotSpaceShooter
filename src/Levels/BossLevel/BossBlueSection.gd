extends "res://src/Levels/BossLevel/BossSection.gd"

onready var bullet_prefab = preload("res://src/Actors/RedBullet.tscn")

func _process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees -= 90

func _on_Timer_timeout():
	for i in range(1, 9):
		var bullet = bullet_prefab.instance()
		get_parent().add_child(bullet)
		bullet.position = get_node("Turret" + str(i)).global_position
		bullet.rotation_degrees = rotation_degrees + 180

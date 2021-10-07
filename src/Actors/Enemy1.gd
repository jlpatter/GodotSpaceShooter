extends Node2D

const SPEED = 100.0

onready var bullet_prefab = preload("res://src/Actors/RedBullet.tscn")

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees += 90
	var dir = Vector2(0.0, -1.0).rotated(rotation)
	position += dir * SPEED * delta


func _on_BulletTimer_timeout():
	var bullet = bullet_prefab.instance()
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawnLocation.global_position
	bullet.rotation = rotation
	bullet.set_speed(SPEED)

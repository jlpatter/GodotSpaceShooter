extends Node2D

const SPEED = 100.0

var is_exploding = false
onready var bullet_prefab = preload("res://src/Actors/RedBullet.tscn")

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees += 90
	var dir = Vector2(0.0, -1.0).rotated(rotation)
	position += dir * SPEED * delta

func explode():
	is_exploding = true
	$GFX.hide()
	$BulletTimer.stop()
	$GenericExplosion.show()
	$GenericExplosion.play()
	$GenericExplosion.play_audio()

func _on_BulletTimer_timeout():
	var bullet = bullet_prefab.instance()
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawnLocation.global_position
	bullet.rotation = rotation
	bullet.set_speed(SPEED)


func _on_Area2D_body_entered(body):
	if "Player" in body.name and not body.is_exploding and not is_exploding:
		body.decrease_health(1000)
		explode()

func _on_Area2D_area_entered(area):
	if "GreenBullet" in area.get_parent().name:
		area.get_parent().queue_free()
		explode()

func _on_GenericExplosion_animation_finished():
	queue_free()

extends Node2D

const SPEED = 200.0

var is_exploding = false

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		look_at(player_node.global_position)
		rotation_degrees += 90
		position += Vector2(0.0, -1.0).rotated(rotation) * SPEED * delta
	if not is_exploding:
		if not $JetSound.playing:
			$JetSound.play()
	else:
		$JetSound.stop()


func explode():
	is_exploding = true
	$RedRocket.hide()
	$Fire.hide()
	$GenericExplosion.show()
	$GenericExplosion.play()
	$GenericExplosion.play_audio()


func _on_Area2D_area_entered(area):
	if "Player" in area.get_parent().name and not is_exploding:
		area.get_parent().decrease_health(50)
		explode()
	elif "GreenBullet" in area.get_parent().name and not is_exploding:
		area.get_parent().queue_free()
		explode()


func _on_GenericExplosion_animation_finished():
	queue_free()

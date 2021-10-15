extends Node2D

var health = 100
var is_exploding = false

func decrease_health(var amount):
	health -= amount
	$HealthBar.show()
	$HealthBar.value = health
	if health <= 0.0:
		explode()

func explode():
	if not is_exploding:
		is_exploding = true
		get_node(name).hide()
		$GenericExplosion.show()
		$GenericExplosion.play()
		$GenericExplosion.play_audio()


func _on_Area2D_area_entered(area):
	if "GreenBullet" in area.get_parent().name:
		area.get_parent().queue_free()
		decrease_health(2)


func _on_GenericExplosion_animation_finished():
	queue_free()

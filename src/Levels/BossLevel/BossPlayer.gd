extends Node2D

const SPEED = 200.0

var is_exploding = false

onready var green_bullet_prefab = preload("res://src/Actors/GreenBullet.tscn")

func _physics_process(delta):
	var velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = green_bullet_prefab.instance()
		get_parent().add_child(bullet)
		bullet.position = $BulletSpawn.global_position
		
		var bullet2 = green_bullet_prefab.instance()
		get_parent().add_child(bullet2)
		bullet2.position = $BulletSpawn2.global_position
		
		var bullet3 = green_bullet_prefab.instance()
		get_parent().add_child(bullet3)
		bullet3.position = $BulletSpawn3.global_position
	
	position += velocity * SPEED * delta

func increase_health(var amount):
	if PlayerVariables.health + amount <= 100:
		PlayerVariables.health += amount
	else:
		PlayerVariables.health = 100
	get_parent().get_node("CanvasLayer2/BossUI/HealthBar").value = PlayerVariables.health

func decrease_health(var amount):
	if PlayerVariables.health - amount >= 0:
		PlayerVariables.health -= amount
	else:
		PlayerVariables.health = 0
	get_parent().get_node("CanvasLayer2/BossUI/HealthBar").value = PlayerVariables.health
	if PlayerVariables.health <= 0 and not is_exploding:
			explode()

func explode():
	is_exploding = true
	$GenericExplosion.show()
	$GenericExplosion.play()
	$GenericExplosion.play_audio()
	$PlayerShip.hide()
	$RGBYFire.hide()
	$FireParticles.hide()


func _on_GenericExplosion_animation_finished():
	get_parent().get_node("CanvasLayer2/GameOverLabel").show()
	queue_free()

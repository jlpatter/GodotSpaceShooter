extends Node2D

var health = 100
var is_exploding = false

onready var green_enemy_prefab = preload("res://src/Levels/BossLevel/GreenEnemy2.tscn")
onready var red_enemy_prefab = preload("res://src/Levels/BossLevel/RedEnemy2.tscn")
onready var blue_enemy_prefab = preload("res://src/Levels/BossLevel/BlueEnemy2.tscn")
onready var yellow_enemy_prefab = preload("res://src/Levels/BossLevel/YellowEnemy2.tscn")

func decrease_health(var amount):
	health -= amount
	$HealthBar.show()
	$HealthBar.value = health
	if health <= 0.0:
		explode()

func explode():
	if not is_exploding:
		is_exploding = true
		$BossGreenSection.hide()
		$GenericExplosion.show()
		$GenericExplosion.play()
		$GenericExplosion.play_audio()

func _on_Area2D_area_entered(area):
	if "GreenBullet" in area.get_parent().name:
		area.get_parent().queue_free()
		decrease_health(2)


func _on_GenericExplosion_animation_finished():
	queue_free()


func _on_SpawnTimer_timeout():
	var color_picker = GlobalVariables.rng.randi() % 4
	var enemy = null
	if color_picker == 0:
		enemy = green_enemy_prefab.instance()
	elif color_picker == 1:
		enemy = red_enemy_prefab.instance()
	elif color_picker == 2:
		enemy = blue_enemy_prefab.instance()
	elif color_picker == 3:
		enemy = yellow_enemy_prefab.instance()
	get_parent().add_child(enemy)
	enemy.position = position

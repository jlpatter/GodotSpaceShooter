extends Node2D

const SPEED = 100.0
const DISTANCE_TO_DETECT_PLAYER = 500.0

var is_following_player = false
var is_exploding = false
onready var bullet_prefab = preload("res://src/Actors/RedBullet.tscn")
onready var health_pack_prefab = preload("res://src/Actors/HealthPack.tscn")

func _ready():
	$BulletTimer.wait_time = GlobalVariables.rng.randf() * 2 + 1
	$BulletTimer.start()

func _physics_process(delta):
	var player_node = get_parent().get_node_or_null("Player")
	if player_node != null:
		is_following_player = true
		look_at(player_node.global_position)
		rotation_degrees += 90
		position += Vector2(0.0, -1.0).rotated(rotation) * SPEED * delta
	else:
		is_following_player = false
	
	if is_following_player and not is_exploding:
		$Fire.show()
		if not $JetSound.playing:
			$JetSound.play()
	else:
		$Fire.hide()
		$JetSound.stop()

func explode():
	is_exploding = true
	$GFX.hide()
	$BulletTimer.stop()
	$GenericExplosion.show()
	$GenericExplosion.play()
	$GenericExplosion.play_audio()

func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = GlobalVariables.rng.randf() * 2 + 1
	if is_following_player:
		var bullet = bullet_prefab.instance()
		get_parent().add_child(bullet)
		bullet.position = $BulletSpawnLocation.global_position
		bullet.rotation = rotation
		bullet.set_speed(SPEED)
		bullet.pause_mode = Node.PAUSE_MODE_STOP
		
		var bullet_spawn_location_2 = get_node_or_null("BulletSpawnLocation2")
		if bullet_spawn_location_2 != null:
			var bullet_2 = bullet_prefab.instance()
			get_parent().add_child(bullet_2)
			bullet_2.position = bullet_spawn_location_2.global_position
			bullet_2.rotation = rotation
			bullet_2.set_speed(SPEED)
			bullet_2.pause_mode = Node.PAUSE_MODE_STOP


func _on_Area2D_body_entered(body):
	if "Player" in body.name and not body.is_exploding and not is_exploding:
		body.decrease_health(50)
		explode()

func _on_Area2D_area_entered(area):
	if "GreenBullet" in area.get_parent().name and not is_exploding:
		area.get_parent().queue_free()
		explode()

func _on_GenericExplosion_animation_finished():
	if GlobalVariables.rng.randi() % 4 == 0:
		var health_pack = health_pack_prefab.instance()
		get_parent().add_child(health_pack)
		health_pack.position = global_position
	queue_free()

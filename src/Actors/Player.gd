extends KinematicBody2D

const SPEED = 10.0
const DECEL_SPEED = 5.0
const ROTATION_SPEED = 2.0

var velocity = Vector2.ZERO
var health = 100
var fuel = 0
var map
var map_is_active = false
var is_exploding = false
onready var bullet_prefab = preload("res://src/Actors/GreenBullet.tscn")
onready var map_prefab = preload("res://src/Levels/Map.tscn")

func _physics_process(delta):
	var rotation_dir = 0.0
	
	if Input.get_action_strength("move_up"):
		velocity += Vector2(
			0.0,
			-Input.get_action_strength("move_up")
		).rotated(rotation) * SPEED
	else:
		if velocity.length() > Vector2.ZERO.length():
			velocity -= velocity.normalized() * DECEL_SPEED
			if velocity.length() < Vector2.ONE.length():
				velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		rotation_dir -= 1
	elif Input.is_action_pressed("move_right"):
		rotation_dir += 1
	
	if Input.get_action_strength("move_up") and not is_exploding:
		$Fire.show()
		if not $JetSound.playing:
			$JetSound.play()
	else:
		$JetSound.stop()
		$Fire.hide()
	
	if Input.is_action_just_pressed("map"):
		activate_map()
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_prefab.instance()
		get_parent().add_child(bullet)
		bullet.set_position($BulletSpawnLocation1.global_position)
		bullet.set_rotation(rotation)
		bullet.set_speed(velocity.length())
		
		var bullet2 = bullet_prefab.instance()
		get_parent().add_child(bullet2)
		bullet2.set_position($BulletSpawnLocation2.global_position)
		bullet2.set_rotation(rotation)
		bullet2.set_speed(velocity.length())
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity)

func activate_map():
	if not map_is_active:
		map_is_active = true
		map = map_prefab.instance()
		get_parent().get_node("CanvasLayer").add_child(map)
	else:
		map_is_active = false
		map.queue_free()

func decrease_health(var amount):
	health -= amount
	get_parent().get_node("CanvasLayer/UI/HealthBar").value = health
	if health <= 0 and not is_exploding:
		explode()

func increase_fuel(var amount):
	fuel += amount
	get_parent().get_node("CanvasLayer/UI/FuelBar").value = fuel

func explode():
	is_exploding = true
	var cam = Camera2D.new()
	cam.position = $Camera2D.global_position
	get_parent().add_child(cam)
	cam.current = true
	$GenericExplosion.show()
	$GenericExplosion.play()
	$GenericExplosion.play_audio()
	$PlayerShip.hide()
	$Fire.hide()


func _on_GenericExplosion_animation_finished():
	queue_free()

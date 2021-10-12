extends KinematicBody2D

const SPEED = 10.0
const WARP_IN_SPEED = 1000.0
const DECEL_SPEED = 5.0
const ROTATION_SPEED = 2.0
const GOD_MODE = false

var velocity = Vector2.ZERO
var map = null
var map_is_active = false
var is_warping_out = false
var is_exploding = false
onready var bullet_prefab = preload("res://src/Actors/GreenBullet.tscn")
onready var map_prefab = preload("res://src/Levels/Map.tscn")

func _ready():
	warp_in()

func _physics_process(delta):
	var rotation_dir = 0.0
	
	if is_warping_out:
		velocity += Vector2(0.0, -1.0).rotated(rotation) * SPEED
		if velocity.length() > 5000:
			get_tree().change_scene("res://src/Levels/Level1.tscn")
	else:
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
			
			var bullet3 = bullet_prefab.instance()
			get_parent().add_child(bullet3)
			bullet3.set_position($BulletSpawnLocation3.global_position)
			bullet3.set_rotation(rotation)
			bullet3.set_speed(velocity.length())
	
	rotation += rotation_dir * ROTATION_SPEED * delta
	move_and_slide(velocity)

func warp_in():
	velocity = Vector2(0.0, -1.0) * WARP_IN_SPEED
	$PlayerShip.hide()
	$WarpIn.show()
	$WarpIn.play()
	$WarpInSound.play()

func warp_out():
	is_warping_out = true
	$PlayerShip.hide()
	$WarpOut.show()
	$WarpOut.play()
	$WarpSound.play()
	$JetSound.stop()
	$Fire.hide()

func add_gem(var gem):
	$PickupGemSound.play()
	if gem == "Green":
		PlayerVariables.has_green = true
		get_parent().get_node("CanvasLayer/UI/GreenGem").show()
	elif gem == "Red":
		PlayerVariables.has_red = true
		get_parent().get_node("CanvasLayer/UI/RedGem").show()
	elif gem == "Blue":
		PlayerVariables.has_blue = true
		get_parent().get_node("CanvasLayer/UI/BlueGem").show()
	elif gem == "Yellow":
		PlayerVariables.has_yellow = true
		get_parent().get_node("CanvasLayer/UI/YellowGem").show()

func activate_map():
	if not map_is_active:
		map_is_active = true
		if map == null:
			map = map_prefab.instance()
			get_parent().get_node("CanvasLayer").add_child(map)
		map.show()
		map.show_gems()
	else:
		map_is_active = false
		map.hide()

func increase_health(var amount):
	if not is_exploding:
		if PlayerVariables.health + amount > 100:
			PlayerVariables.health = 100
		else:
			PlayerVariables.health += amount
		get_parent().get_node("CanvasLayer/UI/HealthBar").value = PlayerVariables.health

func decrease_health(var amount):
	if not GOD_MODE:
		PlayerVariables.health -= amount
		get_parent().get_node("CanvasLayer/UI/HealthBar").value = PlayerVariables.health
		if PlayerVariables.health <= 0 and not is_exploding:
			explode()

func increase_fuel(var amount):
	if PlayerVariables.fuel + amount > 100:
		PlayerVariables.fuel = 100
	else:
		PlayerVariables.fuel += amount
	get_parent().get_node("CanvasLayer/UI/FuelBar").value = PlayerVariables.fuel

func decrease_fuel(var amount):
	if PlayerVariables.fuel - amount < 0:
		PlayerVariables.fuel = 0
	else:
		PlayerVariables.fuel -= amount
	get_parent().get_node("CanvasLayer/UI/FuelBar").value = PlayerVariables.fuel

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


func _on_WarpIn_animation_finished():
	$WarpIn.hide()
	$WarpInSound.stop()
	$PlayerShip.show()

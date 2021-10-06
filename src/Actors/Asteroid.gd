extends Node2D

const SPEED = 10.0
const ROTATION_SPEED = 2.0

var direction

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	direction = Vector2(rng.randf() * 2 - 1, rng.randf() * 2 - 1).normalized()

func _physics_process(delta):
	rotation += ROTATION_SPEED * delta
	position += direction * SPEED * delta

func explode():
	$Explosion.play()

func _on_Area2D_body_entered(body):
	if "GreenBullet" in body.name:
		body.queue_free()
		explode()
	elif "Player" in body.name:
		body.queue_free()
		explode()

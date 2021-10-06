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
	$Asteroid.hide()
	$ExplosionAnim.show()
	$ExplosionAnim.play()

func _on_Area2D_body_entered(body):
	if "GreenBullet" in body.name:
		body.queue_free()
		explode()
	elif "Player" in body.name:
		body.queue_free()
		explode()


func _on_ExplosionAnim_animation_finished():
	queue_free()


func _on_ExplosionAnim_frame_changed():
	if $ExplosionAnim.frame == 3:
		$Explosion.play()

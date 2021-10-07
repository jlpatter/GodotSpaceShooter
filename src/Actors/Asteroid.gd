extends Node2D

const SPEED = 10.0
const ROTATION_SPEED = 2.0

var direction
var is_exploding = false

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	direction = Vector2(rng.randf() * 2 - 1, rng.randf() * 2 - 1).normalized()

func _physics_process(delta):
	rotation += ROTATION_SPEED * delta
	position += direction * SPEED * delta

func explode():
	is_exploding = true
	$Asteroid.hide()
	$ExplosionAnim.show()
	$ExplosionAnim.play()

func _on_Area2D_body_entered(body):
	if "Player" in body.name and not is_exploding:
		body.decrease_health(50)
		explode()

func _on_Area2D_area_entered(area):
	if "GreenBullet" in area.get_parent().name and not is_exploding:
		area.get_parent().queue_free()
		explode()

func _on_ExplosionAnim_animation_finished():
	queue_free()

func _on_ExplosionAnim_frame_changed():
	if $ExplosionAnim.frame == 3:
		$Explosion.play()

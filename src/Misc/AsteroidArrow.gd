extends Polygon2D

var asteroid_to_point_at = null

func _process(delta):
	if is_instance_valid(asteroid_to_point_at) and asteroid_to_point_at != null and not asteroid_inside_of_screen():
		show()
		look_at(asteroid_to_point_at.global_position)
		rotation_degrees -= 90
	else:
		hide()
	var screen_center = get_parent().get_node("Player/Camera2D").get_camera_screen_center()
	position = screen_center + Vector2(0.0, 1.0).rotated(rotation) * ((get_viewport().size.y / 2.0) - polygon[2].y)

func set_asteroid(var asteroid):
	asteroid_to_point_at = asteroid

func asteroid_inside_of_screen():
	var cam_position = Vector2(
		get_parent().get_node("Player/Camera2D").get_camera_screen_center().x - get_viewport().size.x / 2.0,
		get_parent().get_node("Player/Camera2D").get_camera_screen_center().y - get_viewport().size.y / 2.0
	)
	var camera_rect = Rect2(cam_position, get_viewport().size)
	var asteroid_rect = Rect2(asteroid_to_point_at.global_position - Vector2(500.0, 500.0), Vector2(1000.0, 1000.0))
	return camera_rect.intersects(asteroid_rect)

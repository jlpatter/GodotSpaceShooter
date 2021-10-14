extends ColorRect

const COLOR_THRESHOLD = 0.01

var new_color = Color(GlobalVariables.rng.randf(), GlobalVariables.rng.randf(), GlobalVariables.rng.randf(), 1.0)

func _process(delta):
	color = color.linear_interpolate(new_color, 0.01)
	if color_equals(color, new_color):
		new_color = Color(GlobalVariables.rng.randf(), GlobalVariables.rng.randf(), GlobalVariables.rng.randf(), 1.0)


func color_equals(var color1, var color2):
	if abs(color1.r - color2.r) <= COLOR_THRESHOLD and abs(color1.g - color2.g) <= COLOR_THRESHOLD and abs(color1.b - color2.b) <= COLOR_THRESHOLD:
		return true
	return false

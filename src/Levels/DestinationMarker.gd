extends TextureButton

func inside_of(var ui_element):
	var output = rect_position.x + rect_size.x >= ui_element.rect_position.x
	output = output and rect_position.x <= ui_element.rect_position.x + ui_element.rect_size.x
	output = output and rect_position.y + rect_size.y >= ui_element.rect_position.y
	output = output and rect_position.y <= ui_element.rect_position.y + ui_element.rect_size.y
	return output

func inside_of_any(var ui_elements):
	for ui_element in ui_elements:
		if ui_element != self and inside_of(ui_element):
			return true
	return false

func _on_DestinationMarker_toggled(button_pressed):
	if button_pressed:
		for c in get_parent().get_children():
			if c != self and c.pressed:
				c.pressed = false

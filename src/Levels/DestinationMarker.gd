extends Control

var id = -1
var is_current = false

func inside_of(var ui_element):
	return get_rect().intersects(ui_element.get_rect())

func inside_of_any(var ui_elements):
	for ui_element in ui_elements:
		if ui_element != self and inside_of(ui_element):
			return true
	return false

func _on_Button_toggled(button_pressed):
	if button_pressed:
		if is_current:
			$Button.pressed = false
		else:
			for c in get_parent().get_children():
				if c != self and c.get_node("Button").pressed:
					c.get_node("Button").pressed = false

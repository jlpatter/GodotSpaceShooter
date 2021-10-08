extends Control



func _on_EngageButton_pressed():
	var pressed_destinations = []
	for c in $Destinations.get_children():
		if c.pressed:
			pressed_destinations.append(c)
	if pressed_destinations.size() != 1:
		print("BLURG!")
		# Display something about only selecting 1.
	else:
		# Blah blah do something about loading properties of the selected destination
		get_tree().change_scene("res://src/Levels/Level1.tscn")


func _on_GoBackButton_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

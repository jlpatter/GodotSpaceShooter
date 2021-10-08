extends Control



func _on_EngageButton_pressed():
	var pressed_destinations = []
	for c in $Destinations.get_children():
		if c.pressed:
			pressed_destinations.append(c)
	if pressed_destinations.size() != 1 or PlayerVariables.fuel < 20:
		print("BLURG!")
		# Display something about only selecting 1 or not having enough fuel.
	else:
		# Blah blah do something about loading properties of the selected destination
		get_parent().get_parent().get_node("Player").decrease_fuel(20)
		get_tree().change_scene("res://src/Levels/Level1.tscn")


func _on_GoBackButton_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

extends Control

onready var destination_marker_prefab = preload("res://src/Levels/DestinationMarker.tscn")

func _ready():
	for i in 20:
		var dest_marker = destination_marker_prefab.instance()
		$Destinations.add_child(dest_marker)
		var x_loc = GlobalVariables.rng.randf() * (rect_size.x - dest_marker.rect_size.x)
		var y_loc = GlobalVariables.rng.randf() * (rect_size.y - dest_marker.rect_size.y)
		dest_marker.rect_position = Vector2(x_loc, y_loc)
		while dest_marker.inside_of($UIRect) or dest_marker.inside_of_any($Destinations.get_children()):
			x_loc = GlobalVariables.rng.randf() * (rect_size.x - dest_marker.rect_size.x)
			y_loc = GlobalVariables.rng.randf() * (rect_size.y - dest_marker.rect_size.y)
			dest_marker.rect_position = Vector2(x_loc, y_loc)
		if i == 0:
			dest_marker.is_current = true
			$CurrentPointer.position.x = dest_marker.rect_position.x + dest_marker.rect_size.x / 2.0 + 2.5
			$CurrentPointer.position.y = dest_marker.rect_position.y - 15.0

func _on_EngageButton_pressed():
	var pressed_destinations = []
	for c in $Destinations.get_children():
		if c.pressed:
			pressed_destinations.append(c)
	if pressed_destinations.size() < 1:
		$OutputLabel.text = "Please select a destination"
		$OutputLabel.show()
	elif pressed_destinations.size() > 1:
		$OutputLabel.text = "Bruh. If you're seeing this then something is borked"
		$OutputLabel.show()
	elif PlayerVariables.fuel < 20:
		$OutputLabel.text = "You do not have enough fuel to jump"
		$OutputLabel.show()
	else:
		# TODO: Blah blah do something about loading properties of the selected destination
		get_parent().get_parent().get_node("Player").decrease_fuel(20)
		get_parent().get_parent().get_node("Player").activate_map()
		get_parent().get_parent().get_node("Player").warp_out()


func _on_GoBackButton_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

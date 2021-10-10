extends Control

const NUM_OF_STARS = 20

onready var destination_marker_prefab = preload("res://src/Levels/DestinationMarker.tscn")

func _ready():
	if LevelVariables.is_first_load:
		LevelVariables.is_first_load = false
		for i in NUM_OF_STARS:
			var dest_marker = destination_marker_prefab.instance()
			$Destinations.add_child(dest_marker)
			dest_marker.id = i
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
			var location = LevelVariables.Location.new()
			location.is_current = dest_marker.is_current
			location.position = dest_marker.rect_position
			LevelVariables.locations[dest_marker.id] = location
	else:
		for i in NUM_OF_STARS:
			var dest_marker = destination_marker_prefab.instance()
			$Destinations.add_child(dest_marker)
			dest_marker.id = i
			dest_marker.is_current = LevelVariables.locations[i].is_current
			dest_marker.rect_position = LevelVariables.locations[i].position
			if LevelVariables.locations[i].is_visited:
				dest_marker.get_node("Button").hide()
				dest_marker.get_node("StarVisited").show()
			if dest_marker.is_current:
				$CurrentPointer.position.x = dest_marker.rect_position.x + dest_marker.rect_size.x / 2.0 + 2.5
				$CurrentPointer.position.y = dest_marker.rect_position.y - 15.0

func _on_EngageButton_pressed():
	var pressed_destinations = []
	for c in $Destinations.get_children():
		if c.get_node("Button").pressed:
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
		for c in $Destinations.get_children():
			if c.is_current:
				LevelVariables.locations[c.id].is_current = false
				LevelVariables.locations[c.id].is_visited = true
		LevelVariables.locations[pressed_destinations[0].id].is_current = true
		get_parent().get_parent().get_node("Player").decrease_fuel(20)
		get_parent().get_parent().get_node("Player").activate_map()
		get_parent().get_parent().get_node("Player").warp_out()


func _on_GoBackButton_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

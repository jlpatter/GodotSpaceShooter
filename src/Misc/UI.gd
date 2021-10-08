extends Control



func _on_StarMapBtn_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

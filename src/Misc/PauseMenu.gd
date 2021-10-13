extends Control



func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	$SettingsMenu.show()


func _on_RestartButton_pressed():
	MapVariables.is_first_load = true
	MapVariables.locations = {}
	MapVariables.current_color = ""
	
	PlayerVariables.health = 100
	PlayerVariables.fuel = 0
	PlayerVariables.has_green = false
	PlayerVariables.has_red = false
	PlayerVariables.has_blue = false
	PlayerVariables.has_yellow = false
	get_tree().paused = false
	get_tree().change_scene("res://src/Levels/Level1.tscn")

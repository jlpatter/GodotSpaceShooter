extends Control



func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	$SettingsMenu.show()

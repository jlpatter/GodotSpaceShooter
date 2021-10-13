extends Control



func _on_MusicCheckBox_toggled(button_pressed):
	if button_pressed:
		SoundtrackScene.play()
	else:
		SoundtrackScene.stop()


func _on_FullscreenCheckBox_toggled(button_pressed):
	if button_pressed:
		OS.window_fullscreen = true
		OS.window_borderless = true
	else:
		OS.window_fullscreen = false
		OS.window_borderless = false


func _on_BackButton_pressed():
	hide()

extends Control

func _ready():
	$HealthBar.value = PlayerVariables.health
	$FuelBar.value = PlayerVariables.fuel

func _on_StarMapBtn_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

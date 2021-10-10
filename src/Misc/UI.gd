extends Control

func _ready():
	$HealthBar.value = PlayerVariables.health
	$FuelBar.value = PlayerVariables.fuel
	if PlayerVariables.has_green:
		$GreenGem.show()

func _on_StarMapBtn_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

extends Control

func _ready():
	$HealthBar.value = PlayerVariables.health
	$FuelBar.value = PlayerVariables.fuel
	if PlayerVariables.has_green:
		$GreenGem.show()
	if PlayerVariables.has_red:
		$RedGem.show()
	if PlayerVariables.has_blue:
		$BlueGem.show()
	if PlayerVariables.has_yellow:
		$YellowGem.show()

func _on_StarMapBtn_pressed():
	get_parent().get_parent().get_node("Player").activate_map()

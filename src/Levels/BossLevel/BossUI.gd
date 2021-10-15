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

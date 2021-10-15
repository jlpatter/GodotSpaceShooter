extends "res://src/Levels/BossLevel/BossSection.gd"

onready var red_missile_prefab = preload("res://src/Levels/BossLevel/RedMissile.tscn")


func _on_MissileTimer_timeout():
	var red_missile = red_missile_prefab.instance()
	get_parent().add_child(red_missile)
	red_missile.position = position

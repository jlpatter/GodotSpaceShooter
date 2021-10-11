extends Node

var is_first_load = true
var locations = {}

class Location:
	var is_current = false
	var is_visited = false
	var position = Vector2.ZERO

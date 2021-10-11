extends Node

var is_first_load = true
var locations = {}
var current_color = ""

class Location:
	var is_current = false
	var is_visited = false
	var color = ""
	var position = Vector2.ZERO

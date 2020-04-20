extends Node


var room_array = []
var a_star
var virtual_rooms = []
var direction = ""
var biome = "forest"
var cursor = load("res://tiles/cursor.png")
func _ready():
	Input.set_custom_mouse_cursor(cursor)

extends Node


var room_array = []
var a_star
var virtual_rooms = []
var direction = ""
var cursor = load("res://tiles/cursor.png")
var biome = 'hell'
func _ready():
	Input.set_custom_mouse_cursor(cursor)

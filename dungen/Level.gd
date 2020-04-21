extends Node


var room_array = []
var a_star
var virtual_rooms = []
var town = ""
var end = false
var direction = ""
var cursor = load("res://tiles/cursor.png")
var biome = 'forest'
func _ready():
	Input.set_custom_mouse_cursor(cursor)

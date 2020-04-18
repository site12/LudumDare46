extends Node2D

class_name room

export var sizex = 5
export var sizey = 5
var connected_rooms = []

var tilesize = 128/2
var roompos = global_position
onready var tile = $tile

func _init():
	generate_floor(sizex,sizey)
	

func generate_floor(x,y):
	for xpos in sizex:
		for ypos in sizey:
			var t = tile.instance()
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			add_child(t)
			
	

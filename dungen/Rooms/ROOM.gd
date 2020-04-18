extends Node2D

class_name room

export var sizex = 0
export var sizey = 0
export var sizemin = 8
export var sizemax = 16

var tilesize = 128/2
var roompos = global_position
onready var tile = $tile

func _init():
	randomize()
	sizex = rand_range(sizemin,sizemax)
	randomize()
	sizey = rand_range(sizemin,sizemax)
	generate_floor(sizex,sizey)
	

func generate_floor(x,y):
	for xpos in sizex:
		for ypos in sizey:
			var t = tile.instance()
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			add_child(t)
			
	

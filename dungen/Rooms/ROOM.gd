extends Node2D

class_name room

export var size = Vector2(13,10)
var ground = []
var connected_rooms = []

var tilesize = 128/2
var roompos = global_position
onready var tile = load("res://dungen/Rooms/floorTile.tscn")

func _ready():
	generate_floor(size)
	

func generate_floor(size):
	for xpos in size.x:
		ground.append([])
		for ypos in size.y:
			var t = tile.instance()
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			ground[xpos].append(t)
			add_child(t)
			
	

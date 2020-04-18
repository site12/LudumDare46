extends Node2D

class_name room


const DOOR = preload('res://dungen/Rooms/doortile.tscn')
const TILE = preload("res://dungen/Rooms/floorTile.tscn")
export var size = Vector2(13,10)
var ground = []
var connected_rooms = {}
var room_type = ''
var pos
var astar_index

var tilesize = 128/2
var roompos = global_position

func _ready():
	generate_floor(size)
	generate_doors()

func create():
	generate_floor(size)
	generate_doors()
	
func thru_door(side):
	var root = get_tree().get_root()
	var level = root.get_node('ROOM')
	root.remove_child(level)
	level.call_deferred("free")
	connected_rooms[side].create()
	root.add_child(connected_rooms[side])

	
func generate_doors():
	for door in connected_rooms.keys():
		var new_door = DOOR.instance()
		new_door.door_side = door
		match door:
			'left':
				new_door.position = Vector2(rand_range(0, size.x), 0)
			'right':
				new_door.position = Vector2(rand_range(0, size.x), size.y)
			'up':
				new_door.position = Vector2(rand_range(0, size.y), 0)
			'down':
				new_door.position = Vector2(rand_range(0, size.y), size.x)
		add_child(new_door)
		#new_door.position = randi() % (max_size - min_size)


func generate_floor(size):
	for xpos in size.x:
		print(xpos)
		ground.append([])
		for ypos in size.y:
			var t = TILE.instance()
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			ground[xpos].append(t)
			add_child(t)
			
	

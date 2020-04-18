extends Node2D

class_name room


const DOOR = preload('res://dungen/Rooms/doortile.tscn')
const TILE = preload("res://dungen/Rooms/floortile.tscn")
const EXTRA = preload('res://dungen/Rooms/extratile.tscn')
const PLAYER = preload('res://player/player.tscn')
export var size = Vector2(10,10)
var current_room = false
var ground = []
var extras = []
var connected_rooms = {}
var room_type = ''
var pos
var astar_index

var tilesize = 64/2
var roompos = global_position

# func _ready():
# 	Engine.set_target_fps(Engine.get_iterations_per_second())
# 	generate_floor(size)
# 	generate_doors()

func create():
	generate_floor(size)
	generate_doors()
	
func thru_door(side):
	if current_room:
		current_room = false
		var root = get_tree().get_root().get_node('world')
		var level = root.get_node('ROOM')
		root.call_deferred('remove_child', level)
		#level.call_deferred("free")
		var new_room = connected_rooms[side]
		#new_room.create()
		root.call_deferred('add_child',new_room)
		#root.get_node('player').position = Vector2(500,500)
		#var player = PLAYER.instance()
		#player.position = Vector2(200,200)
		#root.get_node('ROOM').add_child(player)
		new_room.current_room = true



	
func generate_doors():
	for door in connected_rooms.keys():
		var new_door = DOOR.instance()
		new_door.door_side = door
		match door:
			'left':
				new_door.position = Vector2(-1, rand_range(0, size.y))
				new_door.rotation_degrees = 90
			'right':
				new_door.position = Vector2(size.x, rand_range(0, size.y+1))
				new_door.rotation_degrees = 90
			'up':
				new_door.position = Vector2(rand_range(0, size.x), -1)
			'down':
				new_door.position = Vector2(rand_range(0, size.x), size.y)
		new_door.position*= tilesize
		add_child(new_door)
		#new_door.position = randi() % (max_size - min_size)

func generate_extras(size):
	for xpos in size.x:
		extras.append([])
		for ypos in size.y:
			var t = EXTRA.instance()
			
			t.position = roompos + Vector2(tilesize*xpos+1,tilesize*ypos+1)
			extras[xpos].append(t)
			add_child(t)

func generate_floor(size):
	for xpos in size.x:
		ground.append([])
		for ypos in size.y:
			var t = TILE.instance()
			t.z_index = -1000
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			ground[xpos].append(t)
			add_child(t)
	generate_extras(size)
			
	

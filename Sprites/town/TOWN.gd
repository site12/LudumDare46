

extends Node2D



const DOOR = preload('res://dungen/Rooms/doortile.tscn')
const TILE = preload("res://dungen/Rooms/floortile.tscn")
const EXTRA = preload('res://dungen/Rooms/extratile.tscn')
const PLAYER = preload('res://player/player.tscn')
const ENEMY = [preload('res://enemies/shroomguy.tscn')]
const WALLS = preload('res://dungen/Rooms/walls/wall.tscn')
const COLL = [
preload('res://dungen/Rooms/walls/left.tscn'),
preload('res://dungen/Rooms/walls/right.tscn'),
preload('res://dungen/Rooms/walls/up.tscn'),
preload('res://dungen/Rooms/walls/down.tscn')

]
export var size = Vector2(10,10)
var current_room = false
var ground = []
var extras = []
var enemies = []
var connected_rooms = {}
var doors = {}
var room_type = ''
var pos
var astar_index

var tilesize = 64/2
var roompos = global_position

# func _ready():
# 	Engine.set_target_fps(Engine.get_iterations_per_second())
# 	generate_floor(size)
# 	generate_doors()

func _ready():
	generate_floor(size)
	generate_doors()
	
func thru_door(side):
	if current_room:
		current_room = false
		var root = get_tree().get_root().get_node('world')
		var level = root.get_node('ROOM')
		var player = root.get_node('player')
		root.call_deferred('remove_child', level)
		#level.call_deferred("free")
		var new_room = connected_rooms[side]
		#new_room.create()
		root.call_deferred('add_child',new_room)
		#root.get_node('player').position = Vector2(500,500)
		#var player = PLAYER.instance()
		#player.position = Vector2(200,200)
		#root.get_node('ROOM').add_child(player)
		match side:
			'left':
				player.position = new_room.doors['right'].position + Vector2(-2*tilesize,0)
			'right':
				player.position = new_room.doors['left'].position + Vector2(2*tilesize,0)
			'up':
				player.position = new_room.doors['down'].position + Vector2(0, -2*tilesize)
			'down':
				player.position = new_room.doors['up'].position + Vector2(0, 2*tilesize)


		new_room.current_room = true



	
func generate_doors():
	for door in connected_rooms.keys():
		var new_door = DOOR.instance()
		new_door.door_side = door
		match door:
			'left':
				new_door.position = Vector2(-1, rand_range(1, size.y-1))
				new_door.rotation_degrees = 90
			'right':
				new_door.position = Vector2(size.x, rand_range(1, size.y-1))
				new_door.rotation_degrees = 90
			'up':
				new_door.position = Vector2(rand_range(1, size.x-1), -1)
			'down':
				new_door.position = Vector2(rand_range(1, size.x-1), size.y)
		new_door.position*= tilesize
		doors[door] = new_door
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

func generate_walls(size):
	var r = WALLS.instance()
	r.tile = r.corners[0]
	r.position = roompos + Vector2(tilesize*-2,tilesize*-3.75)
	add_child(r)
	
	#backwall
	for xpos in size.x:
		var t = WALLS.instance()
		var c = COLL[3].instance()
		t.tile = t.tiles[0]
		t.position = roompos + Vector2(tilesize*xpos,tilesize*size.y+32)
		c.position = roompos + Vector2(tilesize*xpos,tilesize*size.y+32)
		add_child(t)
		add_child(c)
	
	#rightwall
	for ypos in size.y+2:
		var t = WALLS.instance()
		var c = COLL[1].instance()
		if ypos == size.y+1:
			t.tile = t.corners[3]
		else:
			t.tile = t.tiles[1]
		t.position = roompos + Vector2(tilesize*size.x+tilesize,tilesize*ypos)
		c.position = roompos + Vector2(tilesize*size.x+tilesize,tilesize*ypos)
		add_child(t)
		add_child(c)
		
	#leftwall
	for ypos in size.y+2:
		var t = WALLS.instance()
		var c = COLL[0].instance()
		if ypos == size.y+1:
			t.tile = t.corners[2]
		else:
			t.tile = t.tiles[2]
		t.position = roompos + Vector2(-tilesize*2,tilesize*ypos)
		c.position = roompos + Vector2(-tilesize*2,tilesize*ypos)
		add_child(t)
		add_child(c)
	
	#frontwall
	for xpos in size.x+2:
		var t = WALLS.instance()
		var c = COLL[2].instance()
		if xpos == size.x+1:
			t.tile = t.corners[1]
		else:
			t.tile = t.tiles[3]
		t.position = roompos + Vector2(tilesize*xpos,tilesize*-3.75)
		c.position = roompos + Vector2(tilesize*xpos,tilesize*-3.75)
		t.z_index = -499
		add_child(t)
		add_child(c)

func generate_gaps(size):
	#treewall
	for xpos in size.x+1:
		var t = TILE.instance()
		t.tree()
		t.z_index = -499
		t.position = roompos + Vector2(tilesize*xpos-tilesize/2,-tilesize+5)
		add_child(t)
	
	#leftwall
	for ypos in size.y+2:
		var t = TILE.instance()
		t.pick()
		t.z_index = -500
		t.position = roompos + Vector2(-tilesize*2,tilesize*ypos)
		add_child(t)
	
	#rightwall
	for ypos in size.y+2:
		var t = TILE.instance()
		t.pick()
		t.z_index = -500
		t.position = roompos + Vector2(tilesize*size.x+tilesize,tilesize*ypos)
		add_child(t)
		
	#backwall
	for xpos in size.x:
		var t = TILE.instance()
		t.pick()
		t.z_index = -500
		t.position = roompos + Vector2(tilesize*xpos,tilesize*size.y+32)
		add_child(t)

func generate_floor(size):
	for xpos in size.x:
		ground.append([])
		for ypos in size.y:
			var t = TILE.instance()
			t.pick()
			t.z_index = -500
			t.position = roompos + Vector2(tilesize*xpos,tilesize*ypos)
			ground[xpos].append(t)
			add_child(t)
	generate_extras(size)
	generate_walls(size)
	generate_gaps(size)
			
	

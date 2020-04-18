extends Node2D

var Room = preload('res://dungen/Room.tscn')
var Generated_Room = preload('res://dungen/Rooms/ROOM.tscn')

var tile_size = 2 	  # size of a tile in the TileMap
var num_rooms = 50  # number of rooms to generate
var min_size = 4  # minimum room size (in tiles)
var max_size = 10  # maximum room size (in tiles)
var hspread = 0  # horizontal spread (in pixels)
var vspread = 0
var cull = 0.5  # chance to cull room

var path  # AStar pathfinding object

func _ready():
	randomize()
	make_rooms()
	
func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(rand_range(-hspread, hspread), rand_range(-vspread, vspread))
		var r = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		r.make_room(pos, Vector2(w, h) * tile_size)
		$Rooms.add_child(r)
	# wait for movement to stop
	yield(get_tree().create_timer(1.1), 'timeout')
	# cull rooms
	var room_positions = []
	for room in $Rooms.get_children():
		if randf() < cull:
			room.queue_free()
		else:
			room.mode = RigidBody2D.MODE_STATIC
			room_positions.append(Vector3(room.position.x,
										  room.position.y, 0))
	yield(get_tree(), 'idle_frame')
	# generate a minimum spanning tree connecting the rooms
	path = find_mst(room_positions)
	Level.a_star = path

	var room_array = []
	for room in $Rooms.get_children():
		var new_room = Generated_Room.instance()
		new_room.size = room.size
		new_room.pos = room.position
		new_room.astar_index = path.get_closest_point(Vector3(new_room.pos.x, new_room.pos.y, 0))
		room_array.append(new_room)


	for room in room_array:
		#yield(get_tree().create_timer(0.1), 'timeout')
		for linked_room in path.get_point_connections(room.astar_index):
			for searched_room in room_array:
				if searched_room.astar_index == linked_room:
					var found_room = searched_room
					var pos_dif = room.pos - found_room.pos
					if abs(pos_dif.x) > abs(pos_dif.y):
						if found_room.pos.x < room.pos.x:
							connect_room(room, found_room, 'left')
						else:
							connect_room(room, found_room, 'right')
					elif abs(pos_dif.x) < abs(pos_dif.y):
						if found_room.pos.y < room.pos.y:
							connect_room(room, found_room, 'down')
						else:
							connect_room(room, found_room, 'up')
					else:
						print('I cant believe youve done this')
	var the_start = start_end(room_array)
	Level.room_array = room_array
	for room in room_array:
		room.create()
	start_game(the_start)
		
	#print(room_array)
func connect_room(room, room_to, direction):
	var directions = ['right', 'up', 'left', 'down']
	if not room.connected_rooms.has(direction):
		room.connected_rooms[direction] = room_to
		#print(str(room)+' Connected ' + direction + ' to '+str(room_to))
	else:
		if direction == 'down':
			connect_room(room, room_to, 'right')
		else:
			connect_room(room, room_to, directions[directions.find(direction)+1])
		
func start_game(start):
	var root = get_tree().get_root().get_node('world')
	var level = root.get_node('Dungen')
	root.remove_child(level)
	level.call_deferred("free")
	#var player = load('res://player/player.tscn')
	#player = player.instance()
	#start.add_child(player)
	#player.position = Vector2(200,200)
	#player.z_index = 10
	start.current_room = true
	#start.create()
	root.add_child(start)

func start_end(room_array):
	var dead_ends = []
	for room in room_array:
		if room.connected_rooms.keys().size() == 1:
			dead_ends.append(room)
	
	var start = dead_ends[randi() % dead_ends.size()]
	start.room_type = 'start'
	dead_ends[randi() % dead_ends.size()].room_type = 'end'
	return start
	

func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),
				 Color(0, 1, 0), false)
	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y),
						  Color(1, 1, 0), 15, true)

func _process(delta):
	update()
	
func _input(event):
	if event.is_action_pressed('ui_select'):
		for n in $Rooms.get_children():
			n.queue_free()
		path = null
		make_rooms()

func find_mst(nodes):
	# Prim's algorithm
	# Given an array of positions (nodes), generates a minimum
	# spanning tree
	# Returns an AStar object
	
	# Initialize the AStar and add the first point
	var path = AStar.new()
	path.add_point(path.get_available_point_id(), nodes.pop_front())
	
	# Repeat until no more nodes remain
	while nodes:
		var min_dist = INF  # Minimum distance so far
		var min_p = null  # Position of that node
		var p = null  # Current position
		# Loop through points in path
		for p1 in path.get_points():
			p1 = path.get_point_position(p1)
			# Loop through the remaining nodes
			for p2 in nodes:
				# If the node is closer, make it the closest
				if p1.distance_to(p2) < min_dist:
					min_dist = p1.distance_to(p2)
					min_p = p2
					p = p1
		# Insert the resulting node into the path and add
		# its connection
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		# Remove the node from the array so it isn't visited again
		nodes.erase(min_p)
	#print(path.get_point_connections(0))
	return path
		

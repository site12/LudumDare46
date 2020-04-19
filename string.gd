extends Node2D


export (float) var length = 100
export (float) var constrain = 1
export (Vector2) var gravity = Vector2(0,0)
export (float) var friction = 0.9
export (bool) var start_pin = true
export (bool) var end_pin = false

var pos: PoolVector2Array
var pos_ex: PoolVector2Array
var count: int
var arrow
var player

onready var mount = preload('res://Rope/Mount.tscn')

func _ready():
	count = get_count(length)
	resize_arrays()
	#init_position()
	# mount = mount.instance()
	# get_parent().add_child(mount)
	# mount.get_node('Joint').node_b = arrow.get_path()
	init_at_player()

func get_count(distance: float):
	var new_count = ceil(distance / constrain)
	return new_count

func resize_arrays():
	pos.resize(count)
	pos_ex.resize(count)

func init_position():
	for i in range(count):
		pos[i] = position + Vector2(constrain *i, 0)
		pos_ex[i] = position + Vector2(constrain *i, 0)
	position = Vector2.ZERO

func init_at_player():
	for i in range(count):
		pos[i] = player.position + arrow.linear_velocity.normalized()*constrain*i
		pos_ex[i] = player.position + arrow.linear_velocity.normalized()*constrain*i
		# pos[i] = player.position + Vector2(constrain*i, 0)
		# pos_ex[i] = player.position + Vector2(constrain *i, 0)
	position = Vector2.ZERO
	$Line2D.points = pos
	visible = true
	

func _process(delta):
	arrow.second_last_point = pos[count-2]
	# if Input.is_action_pressed("click"):	#Move start point
	# 	pos[0] = get_global_mouse_position()
	# 	pos_ex[0] = get_global_mouse_position()
	# 	#find the best feel length ratio
	# 	print("length ratio to distance ",length/pos[count-1].distance_to(pos[0]))
	# if Input.is_action_pressed("right_click"):	#Move start point
	# 	pos[count-1] = get_global_mouse_position()
	# 	pos_ex[count-1] = get_global_mouse_position()
	
	update_points(delta)
	
	#update_distance()	#Repeat to get tighter rope
	#update_distance()
	if Input.is_action_pressed("click"):
		if not player.has_arrow:
			if (player.position - arrow.position).length() > 100:
				retract_rope(delta)
	
	update_distance()
	
	$Line2D.points = pos


func retract_rope(delta):
	if length > 3:
		length -= 1
	count = get_count(length)
	resize_arrays()
	

	# constrain = abs(constrain - 0.1) 
	# for i in range(count):
	# 	if i != 0:
	# 		pos[i] = Vector2((pos[i].x + pos[i-1].x)/2,(pos[i].y + pos[i-1].y)/2)
	#arrow.linear_velocity =  pos[count-2] - arrow.position 

func update_points(delta):
	for i in range (count):
		if i == 0:
			pass
		if i==count-1:
			pass
		# not first and last || first if not pinned || last if not pinned
		if (i!=0 && i!=count-1) || (i==0 && !start_pin) || (i==count-1 && !end_pin):
			var vec2 = (pos[i] - pos_ex[i]) * friction
			pos_ex[i] = pos[i]
			pos[i] += vec2 + (gravity * delta)

func update_distance():
	#for each point in the array
	for i in range(count):
		#If not last node
		if i == count-1:
			if arrow:
				if arrow.linear_velocity.length() > 500:
				
					pos[i] = arrow.position
				else:
					# arrow.linear_velocity = Vector2(pos[i]-arrow.position)
					# arrow.linear_velocity = (Vector2(pos[i]-arrow.position))
					arrow.pos = pos[i]
					
					# mount.position = pos[i]
			return

		#Distance between this point and the next
		var distance = pos[i].distance_to(pos[i+1])
		#The difference between what the distance is and what it should be
		var difference = constrain - distance
		#The percent it's off
		var percent = difference / distance
		#the vector pointing to the next point
		var vec2 = pos[i+1] - pos[i]


		if i == 0:
			if player:
				pos[i] = player.position
				pos[i+1] += vec2 * percent
			# if start_pin:
			# 	pos[i+1] += vec2 * percent
			# else:
			# 	pos[i] -= vec2 * (percent/2)
			# 	pos[i+1] += vec2 * (percent/2)
		# elif i == count-1:
		# 	pass
		else:
			# if i+1 == count-1 && end_pin:
			# 	pos[i] -= vec2 * percent
			# else:
			pos[i] -= vec2 * (percent/2)
			pos[i+1] += vec2 * (percent/2)

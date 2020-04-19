extends Control

func _process(delta):
	if Level.a_star:
		update()

func _draw():
	var path = Level.a_star
	for room in Level.room_array:
		if room.current_room:
			draw_rect(Rect2(room.pos - room.size, room.size * 2),
				 Color(0, 0, 1), false)
		elif room.discovered:
			draw_rect(Rect2(room.pos - room.size, room.size * 2),
					Color(0, 1, 0), false)
		else:
			pass
	if path:
		for p in path.get_points():
			for c in path.get_point_connections(p):
				var pp = path.get_point_position(p)
				var cp = path.get_point_position(c)
				draw_line(Vector2(pp.x, pp.y), Vector2(cp.x, cp.y),
						  Color(1, 1, 0), 2, true)


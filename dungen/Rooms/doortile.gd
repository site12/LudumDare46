extends Area2D

var door_side

func _ready():
	z_index = int(position.y)

func _on_Area2D_body_entered(body):
	if body.is_in_group("extra"):
		body.queue_free()
	print('door!')
	get_parent().thru_door(door_side)

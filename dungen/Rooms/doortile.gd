extends Area2D

var door_side

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("extra"):
		body.queue_free()
	# print('door!')
	if body.is_in_group('player'):
		get_parent().get_parent().thru_door(door_side)

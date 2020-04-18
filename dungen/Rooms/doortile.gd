extends Area2D

var door_side

func _on_Area2D_body_entered(body):
	get_parent().thru_door(door_side)

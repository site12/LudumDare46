extends Area2D

var functional = false

func _on_clearing_body_entered(body):
	if functional:
		if body.is_in_group('player'):
			get_parent().get_parent().get_parent().transition()
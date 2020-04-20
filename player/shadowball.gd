extends RigidBody2D

const EXPLODE = preload('res://player/explode.tscn')

func _on_Timer_timeout():
	get_parent().call_deferred('remove_child', self)
	var expo = EXPLODE.instance()
	get_parent().call_deferred('add_child', expo)
	expo.position = position
	expo.emitting = true
	expo.modulate = Color.purple

func _on_shadowball_body_entered(body):
	if body.is_in_group('enemy'):
		body.hurt(3)
	elif body.is_in_group('player'):
		return
		
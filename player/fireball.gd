extends RigidBody2D

const EXPLODE = preload('res://player/explode.tscn')

func _on_fireball_body_entered(body):
	if body.is_in_group('enemy'):
		body.set_on_fire()
	elif body.is_in_group('player'):
		return
	var expo = EXPLODE.instance()
	get_parent().call_deferred('add_child', expo)
	expo.position = position
	expo.emitting = true
	expo.modulate = Color.red
	get_parent().call_deferred('remove_child', self)
	

extends RigidBody2D


func _on_fireball_body_entered(body):
	if body.is_in_group('enemy'):
		body.set_on_fire()
		$explode.emitting = true
		get_parent().call_deferred('remove_child', self)
	elif body.is_in_group('player'):
		return
	else:
		$explode.emitting = true
		get_parent().call_deferred('remove_child', self)

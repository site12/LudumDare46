extends RigidBody2D

var pos = Vector2.ZERO

func _on_Arrow_body_entered(body):
	if body.is_in_group('enemy'):
		body.hurt(20)

func _integrate_forces(state):
	if not pos == Vector2.ZERO:
		var t = state.get_transform()
		t.origin.x = pos.x
		t.origin.y = pos.y
		state.set_transform(t)
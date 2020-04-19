extends RigidBody2D

var pos = Vector2.ZERO


func _integrate_forces(state):
	if not pos == Vector2.ZERO:
		var t = state.get_transform()
		t.origin.x = pos.x
		t.origin.y = pos.y
		state.set_transform(t)
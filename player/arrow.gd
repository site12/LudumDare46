extends RigidBody2D

var pos = Vector2.ZERO

func _ready():
	get_parent().get_node("Camera2D")

func _on_Arrow_body_entered(body):
	get_parent().get_node("Camera2D").shake(0.2,15,8)
	if body.is_in_group('enemy'):
		body.hurt(20, self)

func _integrate_forces(state):
	if not pos == Vector2.ZERO:
		var t = state.get_transform()
		t.origin.x = pos.x
		t.origin.y = pos.y
		state.set_transform(t)

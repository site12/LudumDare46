extends RigidBody2D

var pos = Vector2.ZERO
var stuck
var stuck_to
var second_last_point

func _ready():
	get_parent().get_node("Camera2D")

func _process(delta):
	if Input.is_action_just_pressed('click'):
		if stuck:
			if stuck_to:
				if stuck_to.is_in_group('enemy'):
					stuck_to.move_and_slide(position - second_last_point) *100
					# stuck = false
					# stuck_to = null
				else:
					stuck = false
		else:
			linear_velocity = Vector2.ZERO

func _on_Arrow_body_entered(body):
	$impact.emitting = true
	get_parent().get_node("Camera2D").shake(0.2,15,8)
	if body.is_in_group('enemy'):
		body.hurt(5, self)
		stuck_to = body
		stuck = true
		

func _integrate_forces(state):
	if stuck and stuck_to:
		pos = stuck_to.position
	if not pos == Vector2.ZERO:
		var t = state.get_transform()
		t.origin.x = pos.x
		t.origin.y = pos.y
		state.set_transform(t)

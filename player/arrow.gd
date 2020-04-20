extends RigidBody2D

var pos = Vector2.ZERO
var rotatoe = Vector2.ZERO
var stuck
var stuck_to
var second_last_point
var colliding = true
var tran

func _ready():
	get_parent().get_node("Camera2D")
	colliding = true
func _process(delta):
	z_index = position.y+10
	if Input.is_action_pressed('pull'):
		colliding = false
		if stuck:
			if is_instance_valid(stuck_to):
				if stuck_to.is_in_group('enemy'):
					stuck_to.move_and_slide((second_last_point - stuck_to.position).normalized() *1000)
					# pos = stuck_to.position
					# stuck = false
					# stuck_to = null
					
				else:
					stuck = false
			else:
				stuck = false
		else:
			linear_velocity = Vector2.ZERO

func body_killed(body):
	stuck = false
	stuck_to = null

func _on_Arrow_body_entered(body):
	if colliding:
		colliding = false
		$impact.emitting = true
		get_parent().get_node("Camera2D").shake(0.2,15,8)
		stuck = true
		if body.is_in_group('enemy'):
			body.hurt(5, self)
			stuck_to = body
			
		else:
			rotatoe = true
		

func _integrate_forces(state):
	if rotatoe:
		tran = state.get_transform()
		rotatoe = false
	if stuck :
		if is_instance_valid(stuck_to):
			print()
			pos = stuck_to.position
		else:
			state.set_transform(tran)

	if not pos == Vector2.ZERO:
		var t = state.get_transform()
		t.origin.x = pos.x
		t.origin.y = pos.y
		state.set_transform(t)

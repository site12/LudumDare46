extends RigidBody2D

var pos = Vector2.ZERO
var rotatoe = Vector2.ZERO
var stuck
var stuck_to
var second_last_point
var colliding = true
var tran
var player

func _ready():
	get_parent().get_node("Camera2D")
	colliding = true
func _process(_delta):
	player = get_parent().get_node('Player')
	if is_instance_valid(player):
		z_index = position.y+10
		if Input.is_action_pressed('pull'):
			if linear_velocity.length()<100:
				colliding = false
			else:
				colliding = true
			if stuck:
				if is_instance_valid(stuck_to):
					if stuck_to.is_in_group('enemy'):
						stuck_to.move_and_slide((player.position - position).normalized() *1000)
						
						# pos = stuck_to.position
						# stuck = false
						# stuck_to = null
						
					else:
						stuck = false
				else:
					stuck = false
			else:
				linear_velocity = Vector2.ZERO
		if Input.is_action_just_released('pull'):
			release()
			stuck = false
			stuck_to = null
		

func body_killed(_body):
	stuck = false
	stuck_to = null

func _on_Arrow_body_entered(body):
	if colliding:
		colliding = false
		$impact.emitting = true
		$impactsound.play()
		get_parent().get_node("Camera2D").shake(0.2,15,8)
		stuck = true
		if body.is_in_group('enemy'):
			body.hurt(global.bow_damage, self)
			stuck_to = body
			stuck_to.can_damage = false
			stuck_to.canattack = false
			
		else:
			rotatoe = true
		
func release():
	if stuck and is_instance_valid(stuck_to):
		stuck_to.can_damage = true
		#stuck_to.canattack = true
		stuck_to.get_node('attacktimer').start()

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

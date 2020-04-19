extends KinematicBody2D

export (int) var speed = 200
const ARROW = preload('res://player/arrow.tscn')
const ROPE = preload('res://verlet.tscn')
var velocity = Vector2()
var has_arrow = true
onready var sprites = $spritehelper/sprites
onready var arrow = ARROW.instance()
onready var rope = ROPE.instance()


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if velocity.x > 0:
		sprites.flip_h = true
		$AnimationPlayer.play("front")
	elif velocity.x < 0:
		sprites.flip_h = false
		$AnimationPlayer.play("front")
	elif velocity == Vector2.ZERO:
		sprites.playing = false
		sprites.frame = 0
		$AnimationPlayer.play("front")
		$AnimationPlayer.stop()
		
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if has_arrow:
			get_parent().get_node("Camera2D").isArrow = true
			var mouse_pos = get_global_mouse_position()
			var my_pos = position
			#print(str(mouse_pos)+'    '+str(my_pos))
			arrow.position = position
			arrow.linear_velocity = Vector2(mouse_pos - my_pos).normalized() * 500*2
			arrow.get_node('CollisionShape2D').rotation = arrow.linear_velocity.angle()
			#arrow.add_(mouse_pos - my_pos)
			#var rope = get_parent().find_node('String')
			get_parent().add_child(arrow)
			if rope:
				rope.player = self
				rope.arrow = arrow
				rope.visible = false
				get_parent().add_child(rope)
			
			has_arrow = false

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	z_index = int(position.y)


func _on_hitbox_body_entered(body):
	if body.get_class() == 'enemy':
		#uhhhh get knocked back and apply modulate and apply damage
		pass

func _on_Collection_body_entered(body):
	# print('arrow!')
	if body.is_in_group('arrow'):
		if body.linear_velocity.length() < 500:
			get_parent().get_node("Camera2D").isArrow = false
			print('got arrow')
			has_arrow = true
			# get_parent().call_deferred('remove_child','arrow')
			# get_parent().call_deferred('remove_child','rope')
			# get_parent().find_node('Mount').find_node('Joint').node_b = null
			get_parent().remove_child(arrow)
			get_parent().remove_child(rope)
			arrow = ARROW.instance()
			rope = ROPE.instance()

			

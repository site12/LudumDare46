extends KinematicBody2D

export (int) var speed = 200
const ARROW = preload('res://player/arrow.tscn')
var velocity = Vector2()
var has_arrow = true
onready var sprites = $spritehelper/sprites


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
	if Input.is_action_pressed('click'):
		get_parent().get_node("Camera2D").shake(0.2,15,8)
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
	if Input.is_action_pressed("click"):
		if has_arrow:
			var arrow = ARROW.instance()
			var mouse_pos = get_global_mouse_position()
			var my_pos = position
			print(str(mouse_pos)+'    '+str(my_pos))
			arrow.position = position
			arrow.linear_velocity = Vector2(mouse_pos - my_pos).normalized() * 1000
			arrow.get_node('Sprite').rotation = arrow.linear_velocity.angle()
			#arrow.add_(mouse_pos - my_pos)
			get_parent().add_child(arrow)
			has_arrow = false

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	z_index = int(position.y)




func _on_hitbox_body_entered(body):
	if body.get_class() == 'enemy':
		#uhhhh get knocked back and apply modulate and apply damage
		pass

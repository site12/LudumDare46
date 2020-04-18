extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
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
		

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	z_index = int(position.y)




func _on_hitbox_body_entered(body):
	if body.get_class() == 'enemy':
		#uhhhh get knocked back and apply modulate and apply damage
		pass

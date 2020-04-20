extends KinematicBody2D

class_name enemy


var speed = 100
var health = 15
var dead = false
onready var sprites = $spritehelper/sprites
onready var obj = get_parent().get_parent().get_parent().get_node("player")
#onready var healthbar = $spritehelper/zGUI/Control/HBoxContainer/ProgressBar


func hurt(damage, arrow):
	move_and_collide(position - arrow.position)
	
	$hurt.emitting = true
	# yield(get_tree().create_timer(0.1), 'timeout')
	# $hurt.emitting = false
	health -= damage
	if health < 0:
		health == 0
		die()
		arrow.body_killed(self)

func knockback(amount: float, direction: Vector2):
	move_and_collide(direction.normalized()*amount)

func die():
	get_parent().call_deferred('remove_child', 'self')
	call_deferred('queue_free')


func get_class(): return "enemy"

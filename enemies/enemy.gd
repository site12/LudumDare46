extends KinematicBody2D

class_name enemy

var speed = 100
var health = 100
onready var sprites = $spritehelper/sprites
onready var anims = $AnimationPlayer
onready var obj = get_parent().get_parent().get_node("player")
onready var healthbar = $spritehelper/zGUI/Control/HBoxContainer/ProgressBar

func _ready():
	anims.play("run")

func hurt(damage, arrow):
	move_and_collide(position - arrow.position)
	
	health -= damage
	if health < 0:
		health == 0
		die()
	else:
		healthbar.value	= health

func die():
	get_parent().call_deferred('remove_child', 'self')
	call_deferred('queue_free')

func _physics_process(delta):
	var dir = (obj.global_position - global_position).normalized()
	if dir.x<0:
		sprites.flip_h = false
	if dir.x>0:
		sprites.flip_h = true
		
	move_and_collide(dir * speed * delta)
	z_index = int(position.y)


func get_class(): return "enemy"

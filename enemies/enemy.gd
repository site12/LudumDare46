extends KinematicBody2D

class_name enemy

var speed = 100
onready var sprites = $spritehelper/sprites
onready var obj = get_parent().get_node("player")

func _physics_process(delta):
	var dir = (obj.global_position - global_position).normalized()
	if dir.x<0:
		sprites.flip_h = false
	if dir.x>0:
		sprites.flip_h = true
		
	move_and_collide(dir * speed * delta)

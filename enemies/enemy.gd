extends KinematicBody2D

class_name enemy

const COINBAG = preload('res://player/coinbag.tscn')

var attack_dir
var speed = 100
var health = 15
var dead = false
var on_fire = false
var fire_time
var frozen = false
onready var sprites = $spritehelper/sprites
onready var obj = get_parent().get_parent().get_parent().get_node("player")
#onready var healthbar = $spritehelper/zGUI/Control/HBoxContainer/ProgressBar

func _process(delta):
	attack_dir = (obj.global_position - global_position).normalized()
		
func hurt(damage, arrow = null):
	#move_and_collide(position - arrow.position)
	if arrow:
		knockback(20, position - arrow.position)
	$hurt.emitting = true
	# yield(get_tree().create_timer(0.1), 'timeout')
	# $hurt.emitting = false
	health -= damage
	if health < 0:
		health == 0
		die()
		if arrow:
			arrow.body_killed(self)

func set_on_fire():
	on_fire = true
	fire_time = 5
	$fire_timer.start()
	#add fire effect

func freeze():
	#Add frozen effects
	modulate = Color.lightskyblue
	frozen = true
	yield(get_tree().create_timer(1.1), 'timeout')
	frozen = false
	modulate = Color.white

func _on_fire_timer_timeout():
	hurt(1)
	fire_time -= 1
	if fire_time > 0:
		$fire_timer.start()
	else:
		#end fire effect
		pass

func knockback(amount: float, direction: Vector2):
	move_and_collide(direction.normalized()*amount)

func die():
	
	var coinbag = COINBAG.instance()
	coinbag.position = position
	get_parent().get_parent().get_parent().call_deferred('add_child', coinbag)
	get_parent().call_deferred('remove_child', 'self')
	call_deferred('queue_free')


func get_class(): return "enemy"

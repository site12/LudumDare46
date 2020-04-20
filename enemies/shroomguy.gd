extends enemy

onready var anims = $player
var awaydist = 250
var canattack = true
var can_damage = true
var dir
onready var d = preload("res://enemies/deadparticlesshroom.tscn")


func _ready():
	pass
	# speed = 0
	# $spritehelper.visible = false
	# $hurt.visible = false
	# $CollisionShape2D.disabled = true
	# yield(get_tree().create_timer(2), 'timeout')
	# $CollisionShape2D.disabled = false
	# $spritehelper.visible = true
	# $hurt.visible = true
	# speed = 100
	# visible = true

func hurt(damage, arrow=null):
	.hurt(damage,arrow)
	anims.play("hurt")
	$damage.play()
	
	
func _physics_process(delta):
	if dead:
		die()
		
	dir = Vector2()
	for enemy in get_parent().get_children():
		if (enemy.global_position - global_position).length() < 50:
			dir -= (enemy.global_position - global_position).normalized()*10
	for extra in get_parent().get_parent().get_node('extras').get_children():
		if (extra.global_position - global_position).length() < 50:
			dir -= (extra.global_position - global_position).normalized()*10
	#dir = dir.normalized()
	if (obj.global_position - global_position).length() < 100:
		# speed = 0
		if canattack:
			attack(delta)
	else:
		dir += (obj.global_position - global_position)
		#dir = dir.normalized()
		speed = 100
	if dir.x<0:
		sprites.flip_h = false
	if dir.x>0:
		sprites.flip_h = true
	# if abs(dir.length()) > 50:
	dir = dir.normalized() 
	if not frozen:
		move_and_collide(dir * speed * delta)
	z_index = int(position.y)

func attack(delta):
	
	canattack = false
	attack_dir = (obj.global_position - global_position).normalized()
	speed = 100
	move_and_collide(attack_dir * speed*50 * delta)
	$attacktimer.start()
	#dir = -(obj.global_position - global_position).normalized()
	yield(get_tree().create_timer(0.3), 'timeout')
	speed = 100
	move_and_collide(-attack_dir * speed*50 * delta)
	

func _on_attacktimer_timeout():
	canattack = true

func die():
	.die()
	var di = d.instance()
	di.position = position
	get_parent().add_child(di)

	

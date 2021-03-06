extends KinematicBody2D

export (int) var speed = 300
const ARROW = preload('res://player/arrow.tscn')
const ROPE = preload('res://Rope/verlet.tscn')
const FIREBALL = preload('res://player/fireball.tscn')
const SHADOWBALL = preload('res://player/shadowball.tscn')
const EXPLODE = preload('res://player/explode.tscn')
const DIE = preload('res://die.tscn')
const PARTI = preload('res://enemies/deadparticleshuman.tscn')
var next_pos = Vector2.ZERO
var velocity = Vector2()
var has_arrow = true
var interacting = false
var armor = 1
var flame_cloak = false
var dead = false
onready var sprites = $spritehelper/sprites
onready var arrow = ARROW.instance()
onready var rope = ROPE.instance()
onready var healthbar = get_parent().get_node('Camera2D/Control/CanvasLayer/healthbar/ProgressBar')
onready var currency_value = get_parent().get_node('Camera2D/Control/CanvasLayer/healthbar/Label')

func _ready():
	name = 'Player'

func dir():
	if !interacting:
		if Input.is_action_pressed('right'):
			velocity.x += 1
		if Input.is_action_pressed('left'):
			velocity.x -= 1
		if Input.is_action_pressed('down'):
			velocity.y += 1
		if Input.is_action_pressed('up'):
			velocity.y -= 1

func get_input():
	velocity = Vector2()
	dir()
	velocity = velocity.normalized() * speed
	
	if velocity.x > 0:
		sprites.flip_h = true
		$AnimationPlayer.play("front")
	elif velocity.x < 0:
		sprites.flip_h = false
		$AnimationPlayer.play("front")
	elif velocity.y != 0:
		sprites.flip_h = true
		$AnimationPlayer.play("front")
	elif velocity == Vector2.ZERO:
		sprites.playing = false
		sprites.frame = 0
		$AnimationPlayer.play("front")
		$AnimationPlayer.stop()
		
		
func _process(_delta):
	# print(position)
	currency_value.text = str(global.currency)
	if get_parent().name != 'Town':
		if Input.is_action_just_pressed("click") and !interacting:
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

		if Input.is_action_pressed('pull'):
			if (arrow.position - position).length() < 50:
				collect_arrow()

		if Input.is_action_pressed('magic'):
			
			if $magic_cooldown.time_left == 0:
				$magic_cooldown.wait_time = 0.1
				match global.spell:
					'speed_up': speed_up()
					'health_up': health_up()
					'armor_up': armor_up()
					'whack': whack()
					'fireball': fireball()
					'shadowball': shadowball()
					'flamecloak': 
						flamecloak()
						$magic_cooldown.wait_time = 5
					'fireblast': fireblast()
					'remote_detonate': 
						remote_detonate()
						$magic_cooldown.wait_time = 3
					'freezeblast': freezeblast()
				$magic_cooldown.start()

		if Input.is_action_just_pressed('potion'):
			use_potion()




func hurt(damage):
	$hurt2.play()
	$hurt.emitting = true
	global.health -= damage / armor
	$player.play('hurt')
	healthbar.value = global.health
	if global.health < 0:
		global.health == 0
		die()

func die():
	
	if !dead:
		interacting = true
		dead = true
		print("deadd")
		var t = DIE.instance()
		get_parent().add_child(t)
		var p = PARTI.instance()
		p.position = position
		get_parent().add_child(p)
		$spritehelper/sprites.visible = false
		$shadow.visible = false
		$hurt.visible = false
		$hurt2.pitch_scale = 0.1
		

func speed_up():
	speed += 100
	yield(get_tree().create_timer(2), 'timeout')
	speed -= 100
	#Like probably indicated this somehow

func health_up():
	global.max_health += 40
	global.health += 40
	yield(get_tree().create_timer(2), 'timeout')
	global.max_health -= 40
	global.health = max(global.health-40, 1)

func armor_up():
	armor += 1
	yield(get_tree().create_timer(2), 'timeout')
	armor -= 1

func whack():
	var baddies = get_parent().get_node('ROOM').get_node('enemies').get_children()
	for baddy in baddies:
		var pos_dif = (position - baddy.position)
		if pos_dif.length() < 100:
			var baddy_dp = baddy.attack_dir.normalized().dot(Vector2(get_global_mouse_position() - position).normalized())
			print(baddy_dp)
			if baddy_dp < 0:
				baddy.hurt(5)
				baddy.knockback(50, -pos_dif.normalized())

func fireball():
	var fireball = FIREBALL.instance()
	var mouse_pos = get_global_mouse_position()
	var my_pos = position
	fireball.position = position
	fireball.linear_velocity = Vector2(mouse_pos - my_pos).normalized() * 500
	fireball.z_index = z_index
	get_parent().add_child(fireball)

func shadowball():
	var shadowball = SHADOWBALL.instance()
	var mouse_pos = get_global_mouse_position()
	var my_pos = position
	shadowball.position = position
	shadowball.linear_velocity = Vector2(mouse_pos - my_pos).normalized() * 500
	shadowball.z_index = z_index
	get_parent().add_child(shadowball)

func flamecloak():
	flame_cloak = true
	yield(get_tree().create_timer(3), 'timeout')
	flame_cloak = false

func fireblast():
	var explode = EXPLODE.instance()
	explode.emitting = true
	explode.position = position
	explode.modulate = Color.red
	explode.scale = Vector2(1,1)
	get_parent().call_deferred('add_child', explode)
	var baddies = get_parent().get_node('ROOM').get_node('enemies').get_children()
	for baddy in baddies:
		var pos_dif = (position - baddy.position)
		if pos_dif.length() < 100:
			baddy.hurt(5)
			baddy.knockback(50, -pos_dif.normalized())

func remote_detonate():
	if not has_arrow:
		var explode = EXPLODE.instance()
		explode.emitting = true
		explode.position = arrow.position
		explode.modulate = Color.red
		explode.scale = Vector2(1,1)
		get_parent().call_deferred('add_child', explode)
		var baddies = get_parent().get_node('ROOM').get_node('enemies').get_children()
		for baddy in baddies:
			var pos_dif = (arrow.position - baddy.position)
			if pos_dif.length() < 100:
				baddy.hurt(5)
				baddy.knockback(50, -pos_dif.normalized())

func killshroomguy():
	$killshroomguy.play()

func freezeblast():
	var explode = EXPLODE.instance()
	explode.emitting = true
	explode.position = position
	explode.modulate = Color.aqua
	get_parent().call_deferred('add_child', explode)
	var baddies = get_parent().get_node('ROOM').get_node('enemies').get_children()
	for baddy in baddies:
		var pos_dif = (position - baddy.position)
		if pos_dif.length < 100:
			baddy.freeze()

func use_potion():
	if global.potions > 0:
		global.potions -= 1
		global.health += 20
		healthbar.value = global.health

func collect_arrow():
	get_parent().get_node("Camera2D").isArrow = false
	print('got arrow')
	arrow.release()
	has_arrow = true
	get_parent().remove_child(arrow)
	get_parent().remove_child(rope)
	arrow = ARROW.instance()
	rope = ROPE.instance()

func pickupcoin():
	$pickupcoins.play()

func _physics_process(_delta):
	get_input()
	if next_pos:
		velocity = Vector2.ZERO
		position = next_pos
		next_pos = Vector2.ZERO
	velocity = move_and_slide(velocity)
	z_index = int(position.y)


func _on_hitbox_body_entered(body):
	if body.get_class() == 'enemy':
		if body.can_damage:
			match Level.biome:
				'forest' : hurt(1/armor)
				'cave' : hurt(2/armor)
				'hell' : hurt(3/armor)
				
			if flame_cloak:
				body.set_on_fire()

func _on_Collection_body_entered(body):
	# print('arrow!')
	if body.is_in_group('arrow'):
		if body.linear_velocity.length() < 500:
			collect_arrow()
			

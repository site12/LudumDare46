extends enemy

onready var anims = $player
var awaydist = 250
var attacking = false

func _ready():
	speed = 0
	$spritehelper.visible = false
	$hurt.visible = false
	$CollisionShape2D.disabled = true
	yield(get_tree().create_timer(2), 'timeout')
	$CollisionShape2D.disabled = false
	$spritehelper.visible = true
	$hurt.visible = true
	speed = 100
	visible = true

func hurt(damage, arrow):
	.hurt(damage,arrow)
	anims.play("hurt")
	
func _physics_process(delta):
	if dead:
		die()
	var dir = (obj.global_position - global_position).normalized()
	if (obj.global_position - global_position).length() < 100:
		speed = 0
		attacking = true
	else:
		speed = 100
	if dir.x<0:
		sprites.flip_h = false
	if dir.x>0:
		sprites.flip_h = true
		
	move_and_collide(dir * speed * delta)
	z_index = int(position.y)

func attack():
	
	$attacktimer.start()

extends enemy

onready var anims = $player

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

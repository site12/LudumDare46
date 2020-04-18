extends Camera2D

onready var target = get_parent().get_node("player")

func _physics_process(_delta):
	position = target.position

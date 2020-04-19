extends enemy

func _ready():
	speed = 50
	health = 30
	obj = get_parent().get_node("player")

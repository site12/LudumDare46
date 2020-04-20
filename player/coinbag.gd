extends Node2D

var available = true
onready var player = get_parent().get_node('player')

func _process(_delta):
	if available:
		if (player.position - position).length() < 50:
			available = false
			global.currency += 1
			get_parent().call_deferred('remove_child', self)
			

extends Node2D

var available = true
var player

func _process(_delta):
	player = get_parent().get_node('Player')
	if is_instance_valid(player):
		if available:
			if (player.position - position).length() < 50:
				available = false
				player.pickupcoin()
				global.currency += 1
				get_parent().call_deferred('remove_child', self)
			

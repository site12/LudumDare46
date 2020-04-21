extends Node2D

# const WORLD = preload('res://world/world.tscn')
var available = true
var player

func _process(delta):
	player = get_node('../../Player')
	if is_instance_valid(player):
		if available:
			if (player.position - position).length() < 50:
				available = false
				get_node('../../transition').play(true)
				match Level.biome:
					'forest': Level.biome = 'cave'
					'cave': Level.biome = 'hell'
					'hell': 
						get_tree().change_scene("res://intro text.tscn")
						return
				var old_world = get_parent().get_parent()
				get_tree().get_root().call_deferred('remove_child', old_world)
				get_tree().change_scene('res://world/world.tscn')
				# var world = preload('res://world/world.tscn')
				# world = world.instance()
				# get_tree().get_root().call_deferred('add_child', world)
				
			
		
		

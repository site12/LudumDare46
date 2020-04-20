extends Node2D

const WORLD = preload('res://world/world.tscn')
var available = true
onready var player = get_node('../player')

func _process(delta):
	if available:
		if (player.position - position).length() < 50:
			available = false
			get_node('../transition').play(true)
			match Level.biome:
				'forest': Level.biome = 'cave'
				'cave': Level.biome = 'hell'
				'hell': 
					get_tree().change_scene("res://intro text.tscn")
					return
			get_tree().get_root().call_deferred('add_child', WORLD.instance())
			get_tree().get_root().call_deferred('remove_child', self)
			
		
		

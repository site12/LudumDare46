extends Control


func _on_Button_pressed():
	var item = get_node('ColorRect/ColorRect2/HBoxContainer/name').text
	var cost = int(get_node('ColorRect/ColorRect2/HBoxContainer/name2').text)
	if global.currency >= cost:
		global.currency -= cost
		match item:
			'Potion':
				global.potions += 1
			'Bow Upgrade':
				global.bow_damage += 1
			'Speed up':
				global.spell = 'speed_up' 
			'Health up':
				global.spell = 'health_up'
			'Shadowball':
				global.spell = 'shadowball' 
			'Fireball':
				global.spell = 'fireball'
			'Freezeblast':
				global.spell = 'freezeblast'
			'Armor Up':
				global.spell = 'armor_up'
			'Whack':
				global.spell = 'whack'
			'Flamecloak':
				global.spell = 'flamecloak'
			'Remote Detonate':
				global.spell = 'remote_detonate'
			'fireblast':
				global.spell = 'fireblast'
		get_node('../../../../../../..').update_ui()

extends Control


onready var anchor = $CanvasLayer/Control/ui/list/itemanchor/Control
onready var item = preload("res://itemUi.tscn")
var magic_stock = [
	['Potion', 4], 
	['Potion', 5], 
	['Potion', 3], 
	['Speed up', 20], 
	['Health up', 20], 
	['Shadowball', 50], 
	['Fireball', 40], 
	['Freezeblast', 30],
]
var blacksmith_stock = [
	['Bow Upgrade', 10],
	['Bow Upgrade', 11],
	['Bow Upgrade', 12],
	['Armor Up', 20],
	['Whack', 5],
	['Whack', 5],
	['Whack', 5],
	['Flamecloak', 20],
	['Remote Detonate', 40],
	['fireblast', 40],
]

# Called when the node enters the scene tree for the first time.

func update_ui():
	get_node('CanvasLayer/Control/ui/currency/ColorRect2/Label').text = 'Potions: '+str(global.potions) + '\nCurrent Spell: ' + global.spell
	#do the thing for currency

func shoppe(type):
	$AnimationPlayer.play("init")
	$CanvasLayer/Control/ui/title/ColorRect2/Label.text = type + " Shoppe"
	randomize()
	blacksmith_stock.shuffle()
	magic_stock.shuffle()
	update_ui()
	for x in 5:
		var t = item.instance()
		match type:
			'majick':
				t.get_node('ColorRect/ColorRect2/HBoxContainer/name').text = magic_stock[x][0]
				t.get_node('ColorRect/ColorRect2/HBoxContainer/name2').text = str(magic_stock[x][1])
			'Weapons':
				t.get_node('ColorRect/ColorRect2/HBoxContainer/name').text = blacksmith_stock[x][0]
				t.get_node('ColorRect/ColorRect2/HBoxContainer/name2').text = str(blacksmith_stock[x][1])
		anchor.add_child(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$AnimationPlayer.play_backwards("init")
	yield(get_tree().create_timer(0.3), 'timeout')
	get_parent().comeback()

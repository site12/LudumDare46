extends Node2D

var type = ["potion","blacksmith","house"]
onready var pos = [$pos1.position,$pos2.position,$pos3.position]
onready var mage = preload("res://characters/mage.tscn")
onready var smith = preload("res://characters/blacksmith.tscn")


# Called when the node enters the scene tree for the first time.
func house(house):
	z_index = int(get_global_position().y)
	if house == type[0]:
		$potion.visible = true
		$potion/collision/CollisionShape2D.disabled = false
		randomize()
		var m = mage.instance()
		m.position = pos[rand_range(0,2)]
		m.z_index = int(m.get_global_position().y)
		add_child(m)
	if house == type[1]:
		$blacksmith.visible = true
		$blacksmith/collision/CollisionShape2D.disabled = false
		randomize()
		var s = smith.instance()
		s.position = pos[rand_range(0,2)]
		s.z_index = int(s.get_global_position().y)
		add_child(s)
	if house == type[2]:
		$generic.visible = true
		$generic/collision/CollisionShape2D.disabled = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

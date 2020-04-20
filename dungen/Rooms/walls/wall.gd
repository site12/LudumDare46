extends StaticBody2D

var type = "cave"

var tiles = [load("res://tiles/leaves_tile/sprite_22.png"),
load("res://tiles/leaves_tile/sprite_19.png"),
load("res://tiles/leaves_tile/sprite_18.png"),
load("res://tiles/leaves_tile/sprite_26.png")]

var corners = [load("res://tiles/leaves_tile/sprite_14.png"),
load("res://tiles/leaves_tile/sprite_16.png"),
load("res://tiles/leaves_tile/sprite_21.png"),
load("res://tiles/leaves_tile/sprite_23.png")]

var tile

var side

func _ready():
	if type == "forest":
		tiles = [load("res://tiles/leaves_tile/sprite_22.png"),load("res://tiles/leaves_tile/sprite_19.png"),load("res://tiles/leaves_tile/sprite_18.png"),load("res://tiles/leaves_tile/sprite_26.png")]		
		corners = [load("res://tiles/leaves_tile/sprite_14.png"),load("res://tiles/leaves_tile/sprite_16.png"),load("res://tiles/leaves_tile/sprite_21.png"),load("res://tiles/leaves_tile/sprite_23.png")]
	elif type == "cave":
		tiles = [load("res://tiles/rockwall/sprite_6.png"),load("res://tiles/rockwall/sprite_4.png"),load("res://tiles/rockwall/sprite_5.png"),load("res://tiles/rocks/sprite_06.png")]
		corners = [load("res://tiles/rockwall/sprite_1.png"),load("res://tiles/rockwall/sprite_0.png"),load("res://tiles/rockwall/sprite_2.png"),load("res://tiles/rockwall/sprite_7.png")]
#	if side == "left":
#		$right.enabled = false
#		$left.enabled = true
#	if side == "right":
#		$right.enabled = true
#		$left.enabled = false
func wall():
	pass

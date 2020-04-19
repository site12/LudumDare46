extends StaticBody2D


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
	$Sprite.texture = tile
#	if side == "left":
#		$right.enabled = false
#		$left.enabled = true
#	if side == "right":
#		$right.enabled = true
#		$left.enabled = false


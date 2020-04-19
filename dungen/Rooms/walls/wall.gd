extends Node2D


var tiles = [load("res://tiles/leaves_tile/sprite_22.png"),
load("res://tiles/leaves_tile/sprite_19.png"),
load("res://tiles/leaves_tile/sprite_18.png"),
load("res://tiles/leaves_tile/sprite_26.png")]
var tile

func _ready():
	$Sprite.texture = tile


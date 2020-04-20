extends StaticBody2D

#var cavetiles = [
#	load("res://tiles/rockwalls2/sprite_3.png"),
#	load("res://tiles/rockwalls2/sprite_2.png"),
#	load("res://tiles/rockwalls2/sprite_1.png"),
#	load("res://tiles/rockwalls2/sprite_0.png")]
#var cavecorners = [
#	load("res://tiles/rockwalls2/sprite_4.png"),
#	load("res://tiles/rockwalls2/sprite_5.png"),
#	load("res://tiles/rockwalls2/sprite_6.png"),
#	load("res://tiles/rockwalls2/sprite_7.png")]
var corners = [load("res://tiles/leaves_tile/sprite_22.png"),load("res://tiles/leaves_tile/sprite_19.png"),load("res://tiles/leaves_tile/sprite_18.png"),load("res://tiles/leaves_tile/sprite_26.png")]
var tiles = [load("res://tiles/leaves_tile/sprite_14.png"),load("res://tiles/leaves_tile/sprite_16.png"),load("res://tiles/leaves_tile/sprite_21.png"),load("res://tiles/leaves_tile/sprite_23.png")]
var tile


func _ready():
	pass
	
	
func wall(biome):
	$Sprite.texture = tile
	

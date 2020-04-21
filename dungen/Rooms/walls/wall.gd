extends StaticBody2D

var cavetiles = [
	preload("res://tiles/rockwalls2/sprite_3.png"),
	preload("res://tiles/rockwalls2/sprite_2.png"),
	preload("res://tiles/rockwalls2/sprite_1.png"),
	preload("res://tiles/rockwalls2/sprite_0.png")]
var cavecorners = [
	preload("res://tiles/rockwalls2/sprite_4.png"),
	preload("res://tiles/rockwalls2/sprite_5.png"),
	preload("res://tiles/rockwalls2/sprite_6.png"),
	preload("res://tiles/rockwalls2/sprite_7.png")]
var foresttiles = [
	preload("res://tiles/leaves_tile/sprite_22.png"),
	preload("res://tiles/leaves_tile/sprite_19.png"),
	preload("res://tiles/leaves_tile/sprite_18.png"),
	preload("res://tiles/leaves_tile/sprite_26.png")]
var helltiles = [
	preload("res://tiles/hellwall/sprite_3.png"),
	preload("res://tiles/hellwall/sprite_1-1.png (1).png"),
	preload("res://tiles/hellwall/sprite_1.png"),
	preload("res://tiles/hellwall/sprite_back.png")]
var hellcorners = [
	preload("res://tiles/hellwall/sprite_4.png"),
	preload("res://tiles/hellwall/Sprite_5.png"),
	preload("res://tiles/hellwall/Sprite_6.png"),
	preload("res://tiles/hellwall/Sprite_7.png")]
var forestcorners = [
	preload("res://tiles/leaves_tile/sprite_14.png"),
	preload("res://tiles/leaves_tile/sprite_16.png"),
	preload("res://tiles/leaves_tile/sprite_21.png"),
	preload("res://tiles/leaves_tile/sprite_23.png")]
var corners
var tiles
var tile


func _ready():
	pass
	

func set_biome(biome):
	if biome == 'cave':
		corners = cavecorners
		tiles = cavetiles
	elif biome == 'forest':
		corners = forestcorners
		tiles = foresttiles
	elif biome == 'hell':
		corners = hellcorners
		tiles = helltiles

func wall(biome):
	$Sprite.texture = tile
	

extends Node2D


var tiles = [load("res://tiles/Tilesheet1/ground_45.png"),load("res://tiles/Tilesheet1/ground_36.png")]
var tree = load("res://tiles/leaves_new/sprite_80.png")
var tile
# Called when the node enters the scene tree for the first time.
func pick():
	randomize()
	var t = int(rand_range(0,2))
	#print(t)
	if(t==0):
		tile = tiles[t]
	elif(t==1):
		tile = tiles[t]
	$Sprite.texture = tile

func tree():
	$Sprite.texture = tree



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

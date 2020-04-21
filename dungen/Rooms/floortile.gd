extends Node2D


var type = "cave"
var forest = [load("res://tiles/Tilesheet1/ground_45.png"),load("res://tiles/Tilesheet1/ground_36.png")]
var cave = [load("res://tiles/rocks/sprite_12.png"),load("res://tiles/rocks/sprite_13.png")]
var tree = load("res://tiles/leaves_new/sprite_80.png")
var rock = load("res://tiles/rocks/sprite_09.png")
var tile
# Called when the node enters the scene tree for the first time.
func pick(biome):
	randomize()
	var t = int(rand_range(0,2))
	#print(t)
	if(t==0):
		if biome == "forest":
			tile = forest[t]
		elif biome == "cave":
			tile = cave[t]
	elif(t==1):
		if biome == "forest":
			tile = forest[t]
		elif biome == "cave" || biome == "hell":
			tile = cave[t]
	$Sprite.texture = tile

func tree(biome):
	if biome == "forest":
		$Sprite.texture = tree
	elif biome == "cave":
		$Sprite.texture = rock
	elif biome == "hell":
		$Sprite.texture = rock



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

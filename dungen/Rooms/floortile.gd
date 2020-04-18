extends Node2D


var tiles = [load("res://tiles/Tilesheet1/ground_45.png"),load("res://tiles/Tilesheet1/ground_36.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var t = int(rand_range(0,2))
	#print(t)
	if(t==0):
		$Sprite.texture = tiles[t]
	elif(t==1):
		$Sprite.texture = tiles[t]



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

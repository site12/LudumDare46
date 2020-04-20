extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var house1 = $houses/house_generic
onready var house2 = $houses/house_generic2
onready var house3 = $houses/house_generic3
onready var house4 = $houses/house_generic4

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("load")
	generate_houses()
	dir(Level.direction)

func generate_houses():
	house1.house("house")
	house2.house("potion")
	house3.house("house")
	house4.house("blacksmith")

func killfade():
	$Control.queue_free()

func dir(direction):
	if direction == "North":
		$tilemaps/up.visible = true
	if direction == "South":
		$tilemaps/down.visible = true
	if direction == "East":
		$tilemaps/right.visible = true
	if direction == "West":
		$tilemaps/left.visible = true

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var house1 = $houses/house_generic
onready var house2 = $houses/house_generic2
onready var house3 = $houses/house_generic3
onready var house4 = $houses/house_generic4
const WORLD = preload('res://world/world.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("load")
	generate_houses()
	dir(Level.direction)

func transition():
	$transition.play(true)
	yield(get_tree().create_timer(0.3), 'timeout')
	get_tree().get_root().call_deferred('add_child', WORLD.instance())
	get_tree().get_root().call_deferred('remove_child', self)

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
		$tilemaps/up/clearing.functional = true
	if direction == "South":
		$tilemaps/down.visible = true
		$tilemaps/down/clearing.functional = true
	if direction == "East":
		$tilemaps/right.visible = true
		$tilemaps/right/clearing.functional = true
	if direction == "West":
		$tilemaps/left.visible = true
		$tilemaps/left/clearing.functional = true

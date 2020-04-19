extends Control

# Declare member variables here. Examples:
# var a = 2
export var border_scale = 0.0
export var borderTimer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$borderTime.set_wait_time(borderTimer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$bottomBorder.scale.y = ($borderTime.time_left/$borderTime.wait_time -border_scale)
	$topBorder.scale.y = (border_scale-$borderTime.time_left/$borderTime.wait_time)

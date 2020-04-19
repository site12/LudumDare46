extends Control

export var file = ""
export var textTime = 0.2
var path = ""

func _ready():
	$says/letterTimer.wait_time = textTime

func set_path(pathIn):
	path = pathIn

func get_path():
	return path

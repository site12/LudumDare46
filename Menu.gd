extends Node2D


onready var playbutton = $Control/CanvasLayer/TextureRect/play
onready var quitbutton = $Control/CanvasLayer/TextureRect/quit
onready var anims = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_pressed():
	anims.play("load")
	yield(get_tree().create_timer(1.1), 'timeout')
	get_tree().change_scene("res://player/world.tscn")

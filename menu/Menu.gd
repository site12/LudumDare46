extends Node2D


onready var playbutton = $Control/CanvasLayer/TextureRect/play
onready var quitbutton = $Control/CanvasLayer/TextureRect/quit
onready var anims = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("init")

func killsquare():
	$Control/CanvasLayer/ColorRect2.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_play_pressed():
	anims.play("load")
	yield(get_tree().create_timer(3), 'timeout')
	townbabey()
	
func townbabey():
	
	get_tree().change_scene("res://intro text.tscn")

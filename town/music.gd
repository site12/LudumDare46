extends Node2D


onready var music = [
	preload("res://Music/town - sstw.wav"),
	preload("res://Music/hell - sstw.wav"),
	preload("res://Music/forest - sstw.wav"),
	preload("res://Music/cave - sstw.wav"),
	preload("res://Music/bossfight - sstw.wav")

]


# Called when the node enters the scene tree for the first time.
func play():
	if Level.biome == "forest":
		$AudioStreamPlayer2D.set_stream(music[2])
	if Level.biome == "cave":
		$AudioStreamPlayer2D.set_stream(music[3])
	if Level.biome == "hell":
		$AudioStreamPlayer2D.set_stream(music[1])


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()

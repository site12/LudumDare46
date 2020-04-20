extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func play(forward):
	if forward:
		$AnimationPlayer.play("gameboy")
	else:
		$AnimationPlayer.play_backwards("gameboy")

func black():
	$AnimationPlayer.play("gameboy")
	$AnimationPlayer.stop(false)
	$AnimationPlayer.seek(0.3, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

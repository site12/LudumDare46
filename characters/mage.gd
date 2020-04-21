extends Node2D

var entered = false
var shoptype = "majick"

func _on_interact_body_entered(body):
	if(body.name == "Player"):
		entered = true
		print("interact bitch")
		$near.play("near")
		$e.play("E")
	
func _ready():
	$dialogue.dial.append("I KNOW health potions aren't usually brown, but I swear they're fresh!")
	$dialogue.dial.append("I am THE best wizard in town!")
	$dialogue.dial.append("That blacksmith is pretty handsome... wait huh? Did you want something?")
	$dialogue.dial.append("What do you MEAN I just look like a regular dude? I've got the hat and everything!")

func _input(_event):
	if Input.is_action_pressed("E") and entered:
		entered = false
		$dialogue.dialogue()

func _on_interact_body_exited(body):
	if(body.name == "player"):
		entered = false
		print("leavin bitch")
		$near.play_backwards("near")


func _on_e_animation_finished(anim_name):
	if entered:
		$e.play("E")
	else:
		$e.stop()

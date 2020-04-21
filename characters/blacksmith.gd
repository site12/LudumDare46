extends Node2D

var entered = false
var shoptype = "Weapons"

func _on_interact_body_entered(body):
	if(body.name == "Player"):
		entered = true
		print("interact bitch")
		$near.play("near")
		$e.play("E")

func _ready():
	$dialogue.dial.append("You look kinda scrawny, kid. Are you here to buy a letter-opener?")
	$dialogue.dial.append("I am THE best blacksmith in town!")
	$dialogue.dial.append("If you want potions, check out the wizard in town. He's a pretty handsome guy, too.")
	$dialogue.dial.append("Let me guess, someone stole your sweetroll?")

func _input(_event):
	if Input.is_action_pressed("E") and entered:
		entered = false
		$dialogue.dialogue()

func _on_interact_body_exited(body):
	if(body.name == "player"):
		entered = false
		print("leavin bitch")
		$near.play_backwards("near")


func _on_e_animation_finished(_anim_name):
	if entered:
		$e.play("E")
	else:
		$e.stop()

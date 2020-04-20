extends Control


var dial = [
	"Looking for something?",
	"Price indicates quality here.",
	"Hey buddy. Want to buy something?",
	"Interested in buying something?"
]

var diag = ""
onready var player = get_parent().get_parent().get_parent().get_parent().get_node("player")

onready var label = $CanvasLayer/Node2D/bottom/ColorRect2/Label

func dialogue():
	label.visible_characters = 0
	randomize()
	diag = dial[int(rand_range(0,7))]
	label.text = diag
	$AnimationPlayer.play("begin")
	$texttimer.start()
	player.interacting = true


func _on_texttimer_timeout():
	if label.visible_characters != diag.length():
		label.visible_characters += 1


func _on_bye_pressed():
	$AnimationPlayer.play_backwards("begin")
	get_parent().entered = true
	get_parent().get_node("e").play("E")
	player.interacting = false


func _on_buy_pressed():
	get_parent().get_node("shoppe").shoppe("magick")

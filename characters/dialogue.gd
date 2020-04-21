extends Control


var dial = [
	"Looking for something?",
	"Price indicates quality here.",
	"Hey buddy. Want to buy something?",
	"Interested in buying something?"
]

onready var shoppe = preload("res://shopUI.tscn")
var diag = ""
var player

onready var label = $CanvasLayer/Node2D/bottom/ColorRect2/Label

func _process(delta):
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player")

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
	if is_instance_valid(player):
		player.interacting = false

func comeback():
	$CanvasLayer/Node2D.scale.x = 1

func _on_buy_pressed():
	var s = shoppe.instance()
	add_child(s)
	$CanvasLayer/Node2D.scale.x = 0
	s.shoppe(get_parent().shoptype)

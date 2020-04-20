extends Control


onready var anchor = $CanvasLayer/Control/ui/list/itemanchor/Control
onready var item = preload("res://itemUi.tscn")


# Called when the node enters the scene tree for the first time.

	

func shoppe(type):
	$AnimationPlayer.play("init")
	$CanvasLayer/Control/ui/title/ColorRect2/Label.text = type + " Shoppe"
	for x in 5:
		var t = item.instance()
		anchor.add_child(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$AnimationPlayer.play_backwards("init")

extends Control

var player = ""

func dead():
	$AnimationPlayer.play("die")


func _on_Button_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_quit_pressed():
	get_tree().quit()

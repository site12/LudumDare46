extends KinematicBody2D

var mouse_over = false

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse_over:
		var mousePos = get_viewport().get_mouse_position()
		position += mousePos - global_position

func _on_Control_mouse_entered():
	mouse_over = true
	modulate = Color(0x0000ffff)

func _on_Control_mouse_exited():
	mouse_over = false
	modulate = Color(0xffffffff)

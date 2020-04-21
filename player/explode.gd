extends Particles2D

func _ready():
	yield(get_tree().create_timer(0.3), 'timeout')
	get_parent().call_deferred('remove_child', self)

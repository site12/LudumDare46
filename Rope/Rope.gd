extends Node2D


const PIECE = preload('res://Rope/Link.tscn')

export (int) var pieces = 1

func _ready():
	var parent = $Anchor
	for i in pieces:
		parent = addPiece(parent)

func _process(delta):
	var player = get_parent().find_node('Player')
	if is_instance_valid(player):
		$Anchor.position = player.position

func addPiece(parent):
	var joint = parent.get_node('CollisionShape2D/Joint')
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
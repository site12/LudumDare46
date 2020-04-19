extends Control

var json_result = {}
var dialogues = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	json_result = parse_Json(get_parent().get_path())
	$saysBox.set_visible_characters(0)
	print(json_result)
	set_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func parse_Json(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	file.close()
	return json_result


func set_text():
	var says = json_result['dialogue'+str(dialogues)]["says"]
	says = says.substr(1,says.length()-2)
	$saysBox.text = says


func _on_letterTimer_timeout():
	$saysBox.set_visible_characters($saysBox.get_visible_characters()+1)


func _on_Button_pressed():
	dialogues+=1
	
	if(dialogues<=json_result.size()-1):
		set_text()
		$saysBox.set_visible_characters(0)
	if(dialogues==json_result.size()-1):
		get_parent().get_node("Button").set_text("Continue")
	if(dialogues>json_result.size()-1):
		dialogueDone()

func dialogueDone():
	get_parent().queue_free()

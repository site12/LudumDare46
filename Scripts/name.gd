extends Control

var json_result = {}
var dialogues = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	json_result = parse_Json(get_parent().get_path())
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
	var name = json_result['dialogue'+str(dialogues)]["name"]
	name = name.substr(1,name.length()-2)
	$nameBox.text = name+":"

func _on_Button_pressed():
	dialogues+=1
	
	if(dialogues<=json_result.size()-1):
		set_text()

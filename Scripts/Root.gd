extends Control

var json_result = {}

func _ready():
	$dialogues/button.get_popup().connect("id_pressed",self,"chosenDialogue")


func parse_Json(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	json_result = JSON.parse(json).result
	file.close()
	return json_result

func create_Json(path):
	var file = File.new()
	file.open(path, file.WRITE)
	file.store_line('{"dialogue0":{"name":"peepee","says":"poopoo"}}')
	file.close()

func create_Dialogue(path):
	var file = File.new()
	file.open(path, file.READ_WRITE)
	json_result['dialogue'+str(json_result.size())] = {"name":"","says":""}
	#json_result['dialogue1']["name"] = 'test'
	file.store_line(JSON.print(json_result))
	
	file.close()
	
	
	

func _on_create_pressed():
	$createFile.popup_centered()


func _on_quit_pressed():
	get_tree().quit()


func _on_createFile_confirmed():
	create_Json($createFile.current_path)
	$created.popup_centered()

func _on_openFile_file_selected(path):
	json_result = parse_Json(path)
	$dialogues.popup_centered()

func _on_open_pressed():
	$openFile.popup_centered()

func _on_back2_pressed():
	$editor.hide()



func _on_done_pressed():
	pass




func _on_button_pressed():
	$dialogues/button.get_popup().clear()
	for x in range(json_result.size()):
		$dialogues/button.get_popup().add_item('Dialogue '+str(x+1),x) # Replace with function body.


func chosenDialogue(ID):
	var name = json_result['dialogue'+str(ID)]["name"]
	name = name.substr(1,name.length()-2)
	var says = json_result['dialogue'+str(ID)]["says"]
	says = says.substr(1,says.length()-2)
	$editor/namestuff/nameBox.set_text(name)
	$editor/saystuff/saysBox.set_text(says)
	$editor.popup()
	$editor.ID = ID


func _on_newDialogue_pressed():
	create_Dialogue($openFile.current_path)

func saveDialogue(ID):
	var file = File.new()
	file.open($openFile.current_path, file.READ_WRITE)
	json_result['dialogue'+str(ID)] = {"name":'"'+str($editor/namestuff/nameBox.get_text())+'"',"says":'"'+str($editor/saystuff/saysBox.get_text())+'"'}
	#json_result['dialogue1']["name"] = 'test'
	file.store_line(JSON.print(json_result))
	file.close()


func _on_save_pressed():
	saveDialogue($editor.ID)


func _on_preview_pressed():
	$dialogues.hide()
	var preview = load("res://DialogueScene/Dialogue.tscn")
	var preview_instance = preview.instance()
	preview_instance.set_path($openFile.current_path)
	print(preview_instance.path)
	print($openFile.current_path)
	
	
	add_child(preview_instance)

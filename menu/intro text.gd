extends MarginContainer


var townNames = [
"Marbach",
"Biasca",
"Sonogno",
"Winterthur",
"Aarberg",
"Glion",
"San Bergutt",
"Schuls",
"Laufenburg",
"Jungfrau",
"Bougnois",
"Hospental",
"Melchtal",
"Cham",
"Vulpera",
"Rougemont",
"Noirmont",
"Montreux",
"Rabius",
"Muhlehorn",
"Basel",
"Loco",
"Piotta",
"Tamins",
"Granichen",
"Berne",
"Ottikon",
"Buchegg",
"Truns",
"Wildkirchli",
"Lungern",
"Cully",
"Erlach",
"Sierre",
"Engelberg",
"Niederbauen",
"Belp",
"Zermatt",
"Faulensee",
"Ranft",
"Bubikon",
"Surses",
"Lichtensteig",
"Aeschi",
"Rueras",
"Oberglatt",
"Wolfwil",
"Broc",
"Raron",
"Tarasp"
]

var dirs = [
"North",
"South",
"East",
"West"
]

var quips = [
"They've got the only bar around!",
"You probably don't have much else going on.",
"Your third cousin's girlfriend's dentist lives there!",
"Mike told you to!",
"You used to be sweet on a girl from there!",
"They've got toilet paper in stock!'",
"I (ludum)dare you!",
"They'll toss a coin your way if you do!",
"I swear this is a one-time thing.",
"Or like, whatever. Do what you want."
]

onready var Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Label.text = "An evil army approaches the town of " + townNames[rand_range(0,49)]+" from the "+dirs[rand_range(0,3)]+". Protect it at all costs! " +quips[rand_range(0,9)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	yield(get_tree().create_timer(.1), 'timeout')
	get_tree().change_scene("res://world/world.tscn")

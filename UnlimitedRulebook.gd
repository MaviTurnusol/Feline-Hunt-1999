extends Node

var currSave = SAVE_PATH_1
var foodDb = {}
#nodes -> all constant
var rulebook
var nonActionPlayer
var actionPlayer
var hud
var cafeHud
var stealthBar
var streetScene
var apartmentScene
var catSpawnerArray = []
var catArray = []
#stats -> not constant
var physical = 3 : set = set_physical
var mental = 3 : set = set_mental
var money = 20
var health = 100
var furnitureValues = 0
var furnitureInventory = ["bar chair", "bar chair", "bar chair", "bar chair", "bar chair"]
var foodInventory = ["Cosmic Bread", "Uranium Bread"]
var catCount = 0

#activity/time
var acti1 = "Rest"
var acti2 = "Rest"
var acti3 = "Rest"
var acti4 = "Rest"
var actirray = ["Rest", "Rest", "Rest", "Rest"]
#not constant
var currActi = 0
var currDay = 0
#is constant
var huntDuration = 120
var deltaHuntConstant = 0

var bpm := 100.0

#global events -> not constant
var isHandFull = false
var cafeMode = false

const SAVE_PATH_1 = "user://save1.json"
const SAVE_PATH_2 = "user://save2.json"
const SAVE_PATH_3 = "user://save3.json"

func set_physical(value):
	if value > 5:
		physical = 5
		return
	if value < 0:
		physical = 0
		return
	physical = value

func set_mental(value):
	if value > 5:
		mental = 5
		return
	if value < 0:
		mental = 0
		return
	mental = value

func save_game(selSave):
	var file = FileAccess.open(selSave, FileAccess.WRITE)
	
	var save_dict = {
		"physical" = physical,
		"mental" = mental,
		"money" = money,
		"health" = health,
		"furnitureValues" = furnitureValues,
		"furnitureInventory" = furnitureInventory,
		"foodInventory" = foodInventory,
		"catCount" = catCount,
		"currActi" = currActi,
		"currDay" = currDay
	}

	file.store_line(JSON.stringify(save_dict))
	pass
	
func load_game(selSave):
	currSave = selSave
	var file := FileAccess.open(selSave, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	
	physical = save_dict["physical"]
	mental = save_dict["mental"]
	money = save_dict["money"]
	health = save_dict["health"]
	furnitureValues = save_dict["furnitureValues"]
	furnitureInventory = save_dict["furnitureInventory"]
	foodInventory = save_dict["foodInventory"]
	catCount = save_dict["catCount"]
	currActi = save_dict["currActi"]
	currDay = save_dict["currDay"]
	
	get_tree().change_scene_to_file("res://apartment_scene_main.tscn")

func _ready():
	foodDb = {
		"Bread": ["Bread", +1, 0, "res://Sprites/bread.png"],
		"Anti Bread": ["Anti Bread", -1, 0, "res://Sprites/antibread.png"],
		"Rare Bread": ["Rare Bread", +2, 0, "res://Sprites/rarebread.png"],
		"Epic Bread": ["Epic Bread", +3, 0, "res://Sprites/epicbread.png"],
		"Legendary Bread": ["Legendary Bread", +4, 0, "res://Sprites/legendarybread.png"],
		"Cosmic Bread": ["Cosmic Bread", +5, 0, "res://Sprites/cosmicbread.png"],
		"Flipped Bread": ["Flipped Bread", 0, +1, "res://Sprites/flippedbread.png"],
		"Uranium Bread": ["Uranium Bread", -5, 0, "res://Sprites/uraniumbread.png"]
	}
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actirray[0] = acti1
	actirray[1] = acti2
	actirray[2] = acti3
	actirray[3] = acti4
	
	var huntStarted = false
	huntDuration = 0
	for element in actirray.size():
		if element >= currActi:
			if actirray[element] == "Hunt":
				huntStarted = true
				huntDuration += 120
			if huntStarted && actirray[element] != "Hunt":
				return
	pass

func _do_next_activity():
	if currActi < 4:
		if !actirray.has("empty"):
			match actirray[currActi]:
				"Hunt":
					physical -= 1
					get_tree().change_scene_to_file("res://street_scene_main.tscn")
				"Rest":
					pass
				"Open Cafe":
					pass
				"Shop":
					pass
	else:
		get_tree().change_scene_to_file("res://eating_scene.tscn")

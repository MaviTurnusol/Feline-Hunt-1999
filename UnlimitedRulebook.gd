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
var cam
#stats -> not constant
var physical = 3 : set = set_physical
var mental = 3 : set = set_mental
var money = 20
var health = 100
var furnitureValues = 0
var furnitureInventory = []
var foodInventory = ["Cosmic Bread", "Uranium Bread"]
var furniturePositionDictionary = {}
var catCount = 1
var tutorialDone = false

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
var enteringFromGarden = false
var cafeIncome
var isInTransition = false

var bpm := 90.0

#global events -> not constant
var isHandFull = false
var cafeMode = false
var catsGained = 0

const SAVE_PATH_1 = "user://save1.json"
const SAVE_PATH_2 = "user://save2.json"
const SAVE_PATH_3 = "user://save3.json"

func set_health(value):
	if value > 100:
		value = 100
		health = value
	elif value < 0:
		value = 0
		health = value
	else:
		health = value

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
		"currDay" = currDay,
		"furniturePositionDictionary" = furniturePositionDictionary,
		"tutorialDone" = tutorialDone
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
	furniturePositionDictionary = save_dict["furniturePositionDictionary"]
	tutorialDone = save_dict["tutorialDone"]
	if tutorialDone:
		get_tree().change_scene_to_file("res://apartment_scene_main.tscn")
	else:
		get_tree().change_scene_to_file("res://tutorial_scene.tscn")

func _ready():
	furnitureInventory.append("bar chair")
	foodDb = {
		"Bread": ["Bread", +1, 0, "res://Sprites/bread.png", 5],
		"Anti Bread": ["Anti Bread", -1, 0, "res://Sprites/antibread.png", -5],
		"Rare Bread": ["Rare Bread", +2, 0, "res://Sprites/rarebread.png", 10],
		"Epic Bread": ["Epic Bread", +3, 0, "res://Sprites/epicbread.png", 20],
		"Legendary Bread": ["Legendary Bread", +4, 0, "res://Sprites/legendarybread.png", 50],
		"Cosmic Bread": ["Cosmic Bread", +5, 0, "res://Sprites/cosmicbread.png", 35],
		"Flipped Bread": ["Flipped Bread", 0, +1, "res://Sprites/flippedbread.png", 5],
		"Uranium Bread": ["Uranium Bread", -5, 0, "res://Sprites/uraniumbread.png", 5]
	}
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actirray[0] = acti1
	actirray[1] = acti2
	actirray[2] = acti3
	actirray[3] = acti4
	money = round(money)
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
					get_tree().change_scene_to_file("res://street_scene_main.tscn")
				"Rest":
					Transition.endedScene = "Rest"
					currActi+=1
					save_game(currSave)
					get_tree().change_scene_to_file("res://dream_chase_scene.tscn")
				"Open Cafe":
					Transition.endedScene = "Open Cafe"
					currActi+=1
					cafeIncome = round(catCount*mental*0.6*randf_range(0.5, 2) + sqrt(furnitureValues*randf_range(0.5, 2)*4))
					money += cafeIncome
					save_game(currSave)
					get_tree().change_scene_to_file("res://transition_scene.tscn")
				"Shop":
					save_game(currSave)
					get_tree().change_scene_to_file("res://shop_scene.tscn")
	else:
		get_tree().change_scene_to_file("res://eating_scene.tscn")

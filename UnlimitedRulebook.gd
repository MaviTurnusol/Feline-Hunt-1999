extends Node

var currSave = SAVE_PATH_1

#nodes -> all constant
var rulebook
var nonActionPlayer
var actionPlayer
var hud
var cafeHud
var stealthBar
var streetScene
var apartmentScene

#stats -> not constant
var physical = 3
var mental = 3
var money = 20
var health = 100
var furnitureValues = 0
var furnitureInventory = ["bar chair", "bar chair", "bar chair", "bar chair", "bar chair"]
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

func save_game(selSave):
	var file = FileAccess.open(selSave, FileAccess.WRITE)
	
	var save_dict = {
		"physical" = physical,
		"mental" = mental,
		"money" = money,
		"health" = health,
		"furnitureValues" = furnitureValues,
		"furnitureInventory" = furnitureInventory,
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
	catCount = save_dict["catCount"]
	currActi = save_dict["currActi"]
	currDay = save_dict["currDay"]
	
	get_tree().change_scene_to_file("res://apartment_scene_main.tscn")

func _ready():
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

extends Node

#nodes
var rulebook
var nonActionPlayer
var actionPlayer
var hud
var cafeHud
var stealthBar
var streetScene
var apartmentScene

#stats
var physical = 3
var mental = 3
var money = 20
var health = 100
var furnitureValues = 0
var furnitureInventory = ["bar chair", "bar chair", "bar chair", "bar chair", "bar chair"]

#activity/time
var acti1 = "Rest"
var acti2 = "Rest"
var acti3 = "Rest"
var acti4 = "Rest"
var actirray = ["Rest", "Rest", "Rest", "Rest"]
var currActi = 0
var huntDuration = 120
var deltaHuntConstant = 0

var bpm := 100.0

#global events
var isHandFull = false
var cafeMode = false
# Called when the node enters the scene tree for the first time.
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
					print("asdasd")
					get_tree().change_scene_to_file("res://street_scene_main.tscn")
				"Rest":
					pass
				"Open Cafe":
					pass
				"Shop":
					pass

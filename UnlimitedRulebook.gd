extends Node

#nodes
var rulebook
var nonActionPlayer
var actionPlayer
var hud
var stealthBar

#stats
var physical = 3
var mental = 3
var money = 0
var health = 100

#activity/time
var acti1 = "empty"
var acti2 = "empty"
var acti3 = "empty"
var acti4 = "empty"
var actirray = ["empty", "empty", "empty", "empty"]
var currActi = 0
var huntDuration

var bpm := 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actirray[0] = acti1
	actirray[1] = acti2
	actirray[2] = acti3
	actirray[3] = acti4
	
	for element in actirray:
		huntDuration = 0
		if element == "Hunt":
			huntDuration += 60
	pass

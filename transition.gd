extends Node

var isMentalIncreased = false
var isPhysicalIncreased = false
var endedScene = "Hunt"
var isSuccessful
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enter_from_garden():
	UnlimitedRulebook.enteringFromGarden = true
	get_tree().change_scene_to_file("res://apartment_scene_main.tscn")

func enter_from_kitchen():
	get_tree().change_scene_to_file("res://apartment_scene_main.tscn")

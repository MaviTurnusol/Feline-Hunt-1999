extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBook.closeMusic()
	print("aosdm")
	DialogueManager.show_dialogue_balloon(load("res://sharkDia1.dialogue"), "shark1")
	pass # Replace with function body.

func _process(delta):
	if StoryBook.nom1:
		bothNom()
		StoryBook.nom1 = false
	pass

func bothNom():
	$mommyNom.visible = true
	$mommyNom.play("default")
	$sharkNom.visible = true
	$sharkNom.play("default")

func _on_mommy_nom_animation_finished():
	$mommyNom.visible = false
	$mommy.play()
	$cameraShakin.add_trauma(0.5)
	pass # Replace with function body.


func _on_shark_nom_animation_finished():
	$sharkNom.visible = false
	$shark.play()
	pass # Replace with function body.

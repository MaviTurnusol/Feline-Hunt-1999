extends Control

func _ready():
	match Transition.endedScene:
		"Hunt":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "Hunt")
		"Open Cafe":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "OpenCafe")
		"Rest":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "Resting")
		"Tutorial":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "Tutorial")
		"Hospital":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "Hospital")
		"Nightmare":
			DialogueManager.show_example_dialogue_balloon(load("res://transitionDialogue.dialogue"), "Nightmare")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

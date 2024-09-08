extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if FileAccess.file_exists("user://save1.json"):
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_1)
	else:
		UnlimitedRulebook.save_game(UnlimitedRulebook.SAVE_PATH_1)
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_1)
	pass # Replace with function body.


func _on_button_2_pressed():
	if FileAccess.file_exists("user://save2.json"):
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_2)
	else:
		UnlimitedRulebook.save_game(UnlimitedRulebook.SAVE_PATH_2)
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_2)
	pass # Replace with function body.


func _on_button_3_pressed():
	if FileAccess.file_exists("user://save3.json"):
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_3)
	else:
		UnlimitedRulebook.save_game(UnlimitedRulebook.SAVE_PATH_3)
		UnlimitedRulebook.load_game(UnlimitedRulebook.SAVE_PATH_3)
	pass # Replace with function body.

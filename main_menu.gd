extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBook.changeMusicTo(MusicBook.menu)
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


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fall":
		$AnimationPlayer.play("float")
	pass # Replace with function body.


func _on_button_mouse_entered():
	$AudioStreamPlayer.play()
	var posTween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	posTween.tween_property($Button, "position", Vector2(11, 152), 0.25)
	pass # Replace with function body.


func _on_button_2_mouse_entered():
	$AudioStreamPlayer.play()
	var posTween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	posTween.tween_property($Button2, "position", Vector2(11, 188), 0.25)
	pass # Replace with function body.


func _on_button_3_mouse_entered():
	$AudioStreamPlayer.play()
	var posTween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	posTween.tween_property($Button3, "position", Vector2(11, 223), 0.25)
	pass # Replace with function body.


func _on_button_mouse_exited():
	var posTween = get_tree().create_tween()
	posTween.tween_property($Button, "position", Vector2(11, 157), 0.25)
	pass # Replace with function body.


func _on_button_2_mouse_exited():
	var posTween = get_tree().create_tween()
	posTween.tween_property($Button2, "position", Vector2(11, 193), 0.25)
	pass # Replace with function body.


func _on_button_3_mouse_exited():
	var posTween = get_tree().create_tween()
	posTween.tween_property($Button3, "position", Vector2(11, 228), 0.25)

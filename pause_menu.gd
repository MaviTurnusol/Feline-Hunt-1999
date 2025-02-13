extends CanvasLayer

var active = false : set = set_active

func set_active(value):
	if value != active:
		if value:
			$puller.play("pull")
			get_tree().paused = true
		else:
			$puller.play_backwards("pull")
			get_tree().paused = false
		active = value
func _ready():
	$hud/pageBox/easyCatch.button_pressed = UnlimitedRulebook.easyCatch
	$hud/pageBox/HBoxContainer/volumeSlider.value = MusicBook.volume + 20
	$hud/pageBox2/HBoxContainer/moneyEdit.text = str(UnlimitedRulebook.money)
	$hud/pageBox2/spawnRateSlider.value = 100
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		active = !active
	MusicBook.volume = $hud/pageBox/HBoxContainer/volumeSlider.value - 20
	UnlimitedRulebook.money = int($hud/pageBox2/HBoxContainer/moneyEdit.text)
	UnlimitedRulebook.spawnRate = round(201 - $hud/pageBox2/spawnRateSlider.value)
	pass


func _on_easy_catch_toggled(toggled_on):
	if toggled_on:
		UnlimitedRulebook.easyCatch = true
	else:
		UnlimitedRulebook.easyCatch = false
	UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_inf_stamina_toggled(toggled_on):
	if toggled_on:
		UnlimitedRulebook.infiniteStamina = true
	else:
		UnlimitedRulebook.infiniteStamina = false
	pass # Replace with function body.


func _on_helicopter_switch_toggled(toggled_on):
	if toggled_on:
		UnlimitedRulebook.helicopter = true
	else:
		UnlimitedRulebook.helicopter = false
	pass # Replace with function body.

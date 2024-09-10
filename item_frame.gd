extends Control

var item
# Called when the node enters the scene tree for the first time.
func _ready():
	if item != null:
		$itemTexture.texture = load(item[0])
		$HBoxContainer/name.text = item[3]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	if !Input.is_action_pressed("left click") && !UnlimitedRulebook.isHandFull:
		UnlimitedRulebook.isHandFull = true
		UnlimitedRulebook.furnitureInventory.erase(item[3])
		Furnituredb.spawn_furniture(item[3])
		UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
		queue_free()
	pass # Replace with function body.


func _on_frame_texture_button_down():
	$Timer.start()
	pass # Replace with function body.

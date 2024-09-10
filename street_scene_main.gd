extends Node2D

var gonnaSkip = false
# Called when the node enters the scene tree for the first time.
func _ready():
	gonnaSkip = false
	UnlimitedRulebook.streetScene = self
	$countdown.wait_time = UnlimitedRulebook.huntDuration
	$countdown.start()
	$halfFader.play_backwards("fade")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_countdown_timeout():
	$halfFader.play("fade")
	gonnaSkip = true
	pass # Replace with function body.


func _on_half_fader_animation_finished(anim_name):
	if gonnaSkip:
		Transition.endedScene = "Hunt"
		UnlimitedRulebook.currActi += UnlimitedRulebook.huntDuration/120
		UnlimitedRulebook.deltaHuntConstant += 1
		UnlimitedRulebook.catSpawnerArray.clear()
		UnlimitedRulebook.catArray.clear()
		UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
		get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass # Replace with function body.

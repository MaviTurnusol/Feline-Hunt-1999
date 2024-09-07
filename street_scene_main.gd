extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.streetScene = self
	$countdown.wait_time = UnlimitedRulebook.huntDuration
	$countdown.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_countdown_timeout():
	$halfFader.play("fade")
	pass # Replace with function body.


func _on_half_fader_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://apartment_scene_main.tscn")
	UnlimitedRulebook.currActi += UnlimitedRulebook.huntDuration/10
	UnlimitedRulebook.deltaHuntConstant += 1
	pass # Replace with function body.

extends Node2D

var tutu = true
var gonnaChange = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$halfFader.play_backwards("fade")
	$Gato.state = "standing"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Gato.tutorial = true
	if $Gato.state == "tossed":
		$halfFader.play("fade")
		gonnaChange = true
	pass


func _on_half_fader_animation_finished(anim_name):
	if gonnaChange:
		Transition.endedScene = "Tutorial"
		UnlimitedRulebook.tutorialDone = true
		get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass # Replace with function body.

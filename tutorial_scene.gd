extends Node2D

var tutu = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Gato.state = "standing"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Gato.tutorial = true
	if $Gato.state == "tossed":
		$halfFader.play("fade")
	pass


func _on_half_fader_animation_finished(anim_name):
	Transition.endedScene = "Tutorial"
	get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass # Replace with function body.

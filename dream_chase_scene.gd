extends Node2D

var spikeSpeed = 160
var gonnaChange = false
# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBook.changeMusicTo(MusicBook.tutorial)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Countdown.text = str(round($real.time_left))
	pass


func _on_hit_getter_area_entered(area):
	if area.is_in_group("spikeArea"):
		$playerCat.statis = true
		$halfFader.play("eater")
	pass # Replace with function body.

func spawn_spikes():
	spikeSpeed += 10
	for i in randi_range(1, 4):
		var spike = load("res://spike.tscn").instantiate()
		spike.position = Vector2(487 + i*13, 201)
		spike.speed = spikeSpeed
		add_child(spike)


func _on_start_timer_timeout():
	if $real.is_stopped():
		$real.start()
		$starter.play("CountdownPull")
	spawn_spikes()
	$startTimer.wait_time = randf_range(1, 2)
	$startTimer.start()
	pass # Replace with function body.


func _on_real_timeout():
	gonnaChange = true
	$halfFader.play_backwards("fade")
	pass # Replace with function body.


func _on_half_fader_animation_finished(anim_name):
	match anim_name:
		"eater":
			$dumbelek.play("default")
			MusicBook.closeMusic()
		"fade":
			if gonnaChange:
				Transition.endedScene = "Rest"
				get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass # Replace with function body.


func _on_dumbelek_animation_finished():
	$AudioStreamPlayer.play()
	OS.delay_msec(30)
	Transition.endedScene = "Nightmare"
	get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass # Replace with function body.

extends CanvasLayer

var isFirstBeatDone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$beatTimer.wait_time = 60.0/UnlimitedRulebook.bpm
	$beatTimer.start()
	UnlimitedRulebook.hud = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$staminaBar.max_value = 100/6+UnlimitedRulebook.mental*100/6
	$staminaBar.value = UnlimitedRulebook.actionPlayer.stamina
	$hpBar.value = UnlimitedRulebook.health
	#print(UnlimitedRulebook.physical)
	$ClockTexture/timeLabel.text = str(round(UnlimitedRulebook.streetScene.get_node("countdown").time_left))
	pass


func _on_beat_timer_timeout():
	$heartbeat.play("beat")
	if !isFirstBeatDone:
		$beatTimer.wait_time = 60.0/UnlimitedRulebook.bpm
		isFirstBeatDone = true
	$beatTimer.start()

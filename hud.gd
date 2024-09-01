extends CanvasLayer

var isFirstBeatDone = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$beatTimer.wait_time = 60.0/UnlimitedRulebook.bpm + 0.0667
	$beatTimer.start()
	UnlimitedRulebook.hud = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$staminaBar.value = UnlimitedRulebook.actionPlayer.stamina
	$hpBar.value = UnlimitedRulebook.actionPlayer.health
	pass


func _on_beat_timer_timeout():
	$heartbeat.play("beat")
	if !isFirstBeatDone:
		$beatTimer.wait_time = 60.0/UnlimitedRulebook.bpm
		isFirstBeatDone = true
	$beatTimer.start()

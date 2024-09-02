extends Area2D

var counting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if UnlimitedRulebook.actionPlayer.velocity.x < 100:
		monitoring = true
	else:
		monitoring = false
	
	if counting:
		if UnlimitedRulebook.stealthBar.get_node("bar").value == 100:
			counting = false
		UnlimitedRulebook.stealthBar.get_node("bar").value = round(($Timer.wait_time - $Timer.time_left)*100/$Timer.wait_time)
	else:
		UnlimitedRulebook.stealthBar.get_node("bar").value = 0
	pass

func _on_body_entered(body):
	if body.is_in_group("AcPlayer"):
		if($Timer.is_stopped()): $Timer.start()
		counting = true
		UnlimitedRulebook.stealthBar.get_node("bar").visible = true
		UnlimitedRulebook.stealthBar.fadin_in()

func _on_body_exited(body):
	if body.is_in_group("AcPlayer"):
		counting = false
		UnlimitedRulebook.stealthBar.fadin_out()
		$Timer.stop()

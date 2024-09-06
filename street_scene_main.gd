extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$countdown.wait_time = UnlimitedRulebook.huntDuration
	$countdown.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_countdown_timeout():
	pass # Replace with function body.

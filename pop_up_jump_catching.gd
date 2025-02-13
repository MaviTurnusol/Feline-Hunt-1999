extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enab_pressed():
	UnlimitedRulebook.jumpCatchConfigured = true
	UnlimitedRulebook.easyCatch = true
	$puller.play_backwards("pull")
	pass # Replace with function body.


func _on_disab_pressed():
	UnlimitedRulebook.jumpCatchConfigured = true
	UnlimitedRulebook.easyCatch = true
	$puller.play_backwards("pull")
	pass # Replace with function body.

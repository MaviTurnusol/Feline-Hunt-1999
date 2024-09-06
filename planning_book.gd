extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.rulebook = self
	$leftPage/sect1/Activity.activityNum = 1
	$leftPage/sect2/Activity.activityNum = 2
	$leftPage/sect3/Activity.activityNum = 3
	$leftPage/sect4/Activity.activityNum = 4
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

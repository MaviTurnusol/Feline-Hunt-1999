extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.rulebook = self
	$leftPage/sect1/Activity.activityNum = 1
	$leftPage/sect2/Activity.activityNum = 2
	$leftPage/sect3/Activity.activityNum = 3
	$leftPage/sect4/Activity.activityNum = 4
	if UnlimitedRulebook.actirray[$leftPage/sect1/Activity.activityNum-1] != "empty":
			$leftPage/sect1/Activity/selectActivity.text = UnlimitedRulebook.actirray[$leftPage/sect1/Activity.activityNum-1]
	if UnlimitedRulebook.actirray[$leftPage/sect2/Activity.activityNum-1] != "empty":
			$leftPage/sect2/Activity/selectActivity.text = UnlimitedRulebook.actirray[$leftPage/sect2/Activity.activityNum-1]
	if UnlimitedRulebook.actirray[$leftPage/sect3/Activity.activityNum-1] != "empty":
			$leftPage/sect3/Activity/selectActivity.text = UnlimitedRulebook.actirray[$leftPage/sect3/Activity.activityNum-1]
	if UnlimitedRulebook.actirray[$leftPage/sect4/Activity.activityNum-1] != "empty":
			$leftPage/sect4/Activity/selectActivity.text = UnlimitedRulebook.actirray[$leftPage/sect4/Activity.activityNum-1]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$title.text = "Day " + str(UnlimitedRulebook.currDay)
	
	if UnlimitedRulebook.currActi < 4:
		if !UnlimitedRulebook.actirray.has("empty"):
			match UnlimitedRulebook.actirray[UnlimitedRulebook.currActi]:
				"Hunt":
					$rightPage/startDay.text = "Begin Hunt"
				"Rest":
					$rightPage/startDay.text = "Rest"
				"Open Cafe":
					$rightPage/startDay.text = "Open Cafe"
				"Shop":
					$rightPage/startDay.text = "Begin Shopping"
	else:
		$rightPage/startDay.text = "Feast"

	$rightPage/sect2/physicalHealth.text = str(UnlimitedRulebook.physical) + "/5"
	$rightPage/sect3/mentalHealth.text = str(UnlimitedRulebook.mental) + "/5"
	$rightPage/sect1/money.text = str(UnlimitedRulebook.money) + "$"
	pass


func _on_start_day_pressed():
	UnlimitedRulebook._do_next_activity()
	pass # Replace with function body.

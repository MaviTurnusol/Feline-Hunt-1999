extends Control

var activityNum
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if UnlimitedRulebook.currActi+1 > activityNum:
		$cross.visible = true
	pass


func _on_select_activity_pressed():
	$selectActivity.visible = false
	$activityList.visible = true
	if($selectActivity.global_position.y >= 170):
		$activityList.position = Vector2($selectActivity.global_position.x, $selectActivity.global_position.y - 76)
	else:
		$activityList.position = $selectActivity.global_position
	pass # Replace with function body.

func _on_activity_list_index_pressed(index):
	match index:
		0:
			$selectActivity.text = "Hunt"
			match activityNum:
				1:
					UnlimitedRulebook.acti1 = "Hunt"
				2:
					UnlimitedRulebook.acti2 = "Hunt"
				3:
					UnlimitedRulebook.acti3 = "Hunt"
				4:
					UnlimitedRulebook.acti4 = "Hunt"
		1:
			$selectActivity.text = "Open Cafe"
			match activityNum:
				1:
					UnlimitedRulebook.acti1 = "Open Cafe"
				2:
					UnlimitedRulebook.acti2 = "Open Cafe"
				3:
					UnlimitedRulebook.acti3 = "Open Cafe"
				4:
					UnlimitedRulebook.acti4 = "Open Cafe"
		2:
			$selectActivity.text = "Shop"
			match activityNum:
				1:
					UnlimitedRulebook.acti1 = "Shop"
				2:
					UnlimitedRulebook.acti2 = "Shop"
				3:
					UnlimitedRulebook.acti3 = "Shop"
				4:
					UnlimitedRulebook.acti4 = "Shop"
		3:
			$selectActivity.text = "Rest"
			match activityNum:
				1:
					UnlimitedRulebook.acti1 = "Rest"
				2:
					UnlimitedRulebook.acti2 = "Rest"
				3:
					UnlimitedRulebook.acti3 = "Rest"
				4:
					UnlimitedRulebook.acti4 = "Rest"
	$activityList.visible = false
	$selectActivity.visible = true
	pass # Replace with function body.


func _on_activity_list_focus_exited():
	$activityList.visible = false
	$selectActivity.visible = true
	pass # Replace with function body.

extends Control

@onready var itemList = $Panel/ItemList
var selectedBread
var gonnaChange = false
# Called when the node enters the scene tree for the first time.
func _ready():
	gonnaChange = false
	load_items()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_items():
	itemList.clear()
	for item in UnlimitedRulebook.foodInventory:
		itemList.add_item(UnlimitedRulebook.foodDb[item][0], load(UnlimitedRulebook.foodDb[item][3]))


func _on_eat_pressed():
	if selectedBread != null:
		UnlimitedRulebook.physical += UnlimitedRulebook.foodDb[selectedBread][1]
		UnlimitedRulebook.mental += UnlimitedRulebook.foodDb[selectedBread][2]
		UnlimitedRulebook.foodInventory.erase(selectedBread)
		load_items()
		UnlimitedRulebook.currDay += 1
		UnlimitedRulebook.currActi = 0
		UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
		gonnaChange = true
		$halfFader.play_backwards("opening")
	pass # Replace with function body.


func _on_item_list_item_selected(index):
	selectedBread = itemList.get_item_text(index)
	pass # Replace with function body.


func _on_half_fader_animation_finished(anim_name):
	if gonnaChange:
		UnlimitedRulebook.load_game(UnlimitedRulebook.currSave)
	pass # Replace with function body.


func _on_pass_pressed():
		UnlimitedRulebook.currDay += 1
		UnlimitedRulebook.currActi = 0
		UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
		gonnaChange = true
		$halfFader.play_backwards("opening")

extends Control

var randomBreadArray = []
var selectedBread
var breadIndex
var randomFurnitureArray = []
var selectedFurniture
var furnitureIndex
var cost = 0
var gonnaChange = false
# Called when the node enters the scene tree for the first time.
func _ready():
	randomBreadArray.clear()
	randomFurnitureArray.clear()
	for i in 3:
		randomBreadArray.append(UnlimitedRulebook.foodDb.keys()[randi() % UnlimitedRulebook.foodDb.size()])
		$breadPanel/breadList.add_item(randomBreadArray[i], load(UnlimitedRulebook.foodDb[randomBreadArray[i]][3]))
	for i in 7:
		randomFurnitureArray.append(Furnituredb.furnitureDictionary.keys()[randi() % Furnituredb.furnitureDictionary.size()])
		$furniturePanel/furnitureList.add_item(randomFurnitureArray[i],  load(Furnituredb.furnitureDictionary[randomFurnitureArray[i]][0]))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel/money.text = str(UnlimitedRulebook.money) + "$"
	$VBoxContainer/cost.text = str(cost) + "$"
	if $TabBar.current_tab == 0:
		$breadPanel.visible = true
		$furniturePanel.visible = false
	else:
		$breadPanel.visible = false
		$furniturePanel.visible = true


func _on_bread_list_item_selected(index):
	selectedFurniture = null
	selectedBread = $breadPanel/breadList.get_item_text(index)
	breadIndex = index
	cost = UnlimitedRulebook.foodDb[selectedBread][4]
	pass # Replace with function body.

func _on_buy_pressed():
	if UnlimitedRulebook.money >= cost:
		UnlimitedRulebook.money -= cost
		if selectedBread != null:
			UnlimitedRulebook.foodInventory.append(UnlimitedRulebook.foodDb[selectedBread][0])
			randomBreadArray.erase(selectedBread)
			$breadPanel/breadList.remove_item(breadIndex)
			selectedBread = null
			cost = 0
			UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
		if selectedFurniture != null:
			UnlimitedRulebook.furnitureInventory.append(Furnituredb.furnitureDictionary[selectedFurniture][3])
			randomFurnitureArray.erase(selectedFurniture)
			$furniturePanel/furnitureList.remove_item(furnitureIndex)
			selectedFurniture = null
			cost = 0
			UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
	pass # Replace with function body.


func _on_pass_pressed():
	gonnaChange = true
	$halfFader.play_backwards("fade")
	pass # Replace with function body.


func _on_half_fader_animation_finished(anim_name):
	if gonnaChange:
		UnlimitedRulebook.enteringFromGarden = true
		UnlimitedRulebook.currActi += 1
		get_tree().change_scene_to_file("res://apartment_scene_main.tscn")
	pass # Replace with function body.


func _on_furniture_list_item_selected(index):
	selectedBread = null
	selectedFurniture = $furniturePanel/furnitureList.get_item_text(index)
	furnitureIndex = index
	cost = Furnituredb.furnitureDictionary[selectedFurniture][4]
	pass # Replace with function body.

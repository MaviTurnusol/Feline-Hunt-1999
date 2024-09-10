extends CanvasLayer

var itemAmount = 0
var isPulled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.cafeHud = self
	refresh_items()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $ScrollMenu/InventoryList.get_child_count() > 3:
		$ScrollMenu.size.x = $ScrollMenu/InventoryList.get_child_count()*140
	$ScrollMenu/dragArea/CollisionShape2D.shape.extents.x = $ScrollMenu/ColorRect.size.x
	$ScrollMenu/dragArea/CollisionShape2D.shape.extents.y = $ScrollMenu/ColorRect.size.y/1.5
	$ScrollMenu/dragArea/CollisionShape2D.position.x = $ScrollMenu/dragArea/CollisionShape2D.shape.extents.x/2
	$ScrollMenu/dragArea/CollisionShape2D.position.y = $ScrollMenu/dragArea/CollisionShape2D.shape.extents.y/2
	pass


func _on_drag_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("left click"):
			$ScrollMenu.position.x += event.relative.x
			
	pass # Replace with function body.


func _on_button_pressed():
	if isPulled:
		$puller.play_backwards("pull")
		isPulled = false
	else:
		$puller.play("pull")
		isPulled = true
	pass # Replace with function body.

func refresh_items():
	for element in $ScrollMenu/InventoryList.get_children():
		element.queue_free()
		itemAmount -= 1
	for element in UnlimitedRulebook.furnitureInventory:
		var itemFrame = load("res://item_frame.tscn").instantiate()
		itemFrame.item = Furnituredb.furnitureDictionary[element]
		$ScrollMenu/InventoryList.add_child(itemFrame)
		itemAmount += 1

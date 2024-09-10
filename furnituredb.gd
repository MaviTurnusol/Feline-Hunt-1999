extends Node

var furnitureDictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	furnitureDictionary = {
		"bar chair": ["res://Sprites/barChair.png", Vector2(17, 19), 5, "bar chair"]
	}
	pass # Replace with function body.

func spawn_furniture(furni: String):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
	
func spawn_furniture_placed(furni: String, pos: Vector2):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	spawningFurniture.isPlaced = true
	spawningFurniture.spawnPlaced = true
	spawningFurniture.global_position = pos
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node

var furnitureDictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	furnitureDictionary = {
		"bar chair": ["res://Sprites/barChair.png", Vector2(17, 19), 5, "bar chair", 10],
		"wooden chair": ["res://Sprites/woodenChair.png", Vector2(17, 32), 7, "wooden chair", 15],
		"wooden table": ["res://Sprites/woodenTable.png", Vector2(46, 23), 14, "wooden table", 25],
		"modern chair": ["res://Sprites/modernChair.png", Vector2(17, 32), 10, "modern chair", 20],
		"modern table": ["res://Sprites/modernTable.png", Vector2(46, 23), 30, "modern table", 50],
		"umbrella": ["res://Sprites/umbrella.png", Vector2(86, 88), 125, "umbrella", 150],
		"spiked chair": ["res://Sprites/spikyChair.png", Vector2(17, 32), -10, "spiked chair", 5],
		"pot plant": ["res://Sprites/potPlant.png", Vector2(47, 54), 50, "pot plant", 75],
		"sign": ["res://Sprites/wapanesesign.png", Vector2(121, 120), 250, "sign", 300],
		"trash bin": ["res://Sprites/trashCan.png", Vector2(24, 32), 10, "trash bin", 20],
		"statue": ["res://Sprites/ofcatandwomen.png", Vector2(62, 131), 500, "statue", 500],
		"box": ["res://Sprites/box.png", Vector2(32, 19), 1, "box", 2],
		"old robot": ["res://Sprites/fleshbot.png", Vector2(31, 48), 0, "old robot", 0]
	}
	pass # Replace with function body.

func spawn_furniture(furni: String):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
	
func spawn_furniture_placed(furni: String, pos: Vector2, facing: int, nbt: float):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	spawningFurniture.isPlaced = true
	spawningFurniture.spawnPlaced = true
	spawningFurniture.nbtNumber = nbt
	spawningFurniture.scale.x = facing
	spawningFurniture.global_position = pos
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

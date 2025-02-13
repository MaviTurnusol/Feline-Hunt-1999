extends Node

var furnitureDictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	furnitureDictionary = {
		"bar chair": ["res://Sprites/barChair.png", Vector2(17, 19), 5, "bar chair", 10, true],
		"wooden chair": ["res://Sprites/woodenChair.png", Vector2(17, 32), 7, "wooden chair", 15, false],
		"wooden table": ["res://Sprites/woodenTable.png", Vector2(46, 23), 14, "wooden table", 25, true],
		"modern chair": ["res://Sprites/modernChair.png", Vector2(17, 32), 10, "modern chair", 20, false],
		"modern table": ["res://Sprites/modernTable.png", Vector2(46, 23), 30, "modern table", 50, true],
		"umbrella": ["res://Sprites/umbrella.png", Vector2(86, 88), 125, "umbrella", 150, false],
		"spiked chair": ["res://Sprites/spikyChair.png", Vector2(17, 32), -10, "spiked chair", 5, false],
		"pot plant": ["res://Sprites/potPlant.png", Vector2(47, 54), 50, "pot plant", 75, false],
		"sign": ["res://Sprites/wapanesesign.png", Vector2(121, 120), 250, "sign", 300, false],
		"trash bin": ["res://Sprites/trashCan.png", Vector2(24, 32), 10, "trash bin", 20, false],
		"statue": ["res://Sprites/ofcatandwomen.png", Vector2(62, 131), 500, "statue", 500, false],
		"box": ["res://Sprites/box.png", Vector2(32, 19), 1, "box", 2, true],
		"old robot": ["res://Sprites/fleshbot.png", Vector2(31, 48), 0, "old robot", 0, false],
		"arcade statue": ["res://Sprites/arcadeStatue.png", Vector2(35, 65), 200, "arcade statue", 200, false],
		"gelato statue": ["res://Sprites/gelgatoStatue.png", Vector2(35, 50), 200, "gelato statue", 200, false],
		"mythological statue": ["res://Sprites/mythologicalStatue.png", Vector2(42, 51), 200, "mythological statue", 500, false],
		"statue for cats": ["res://Sprites/statueForCats.png", Vector2(35, 65), 200, "statue for cats", 200, false],
		"warrior statue": ["res://Sprites/warriorStatue.png", Vector2(42, 56), 200, "warrior statue", 200, false],
		"hoko statue": ["res://Sprites/hokoStatue.png", Vector2(33, 46), 200, "hoko statue", 200, false]
		
	}
	pass # Replace with function body.

func spawn_furniture(furni: String):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	spawningFurniture.solid = furnitureDictionary[furni][5]
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
	
func spawn_furniture_placed(furni: String, pos: Vector2, facing: int, nbt: float):
	var spawningFurniture = load("res://furniture.tscn").instantiate()
	spawningFurniture.texture = furnitureDictionary[furni][0]
	spawningFurniture.size = furnitureDictionary[furni][1]
	spawningFurniture.value = furnitureDictionary[furni][2]
	spawningFurniture.displayName = furnitureDictionary[furni][3]
	spawningFurniture.solid = furnitureDictionary[furni][5]
	spawningFurniture.isPlaced = true
	spawningFurniture.spawnPlaced = true
	spawningFurniture.nbtNumber = nbt
	spawningFurniture.scale.x = facing
	spawningFurniture.global_position = pos
	UnlimitedRulebook.apartmentScene.add_child.call_deferred(spawningFurniture)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

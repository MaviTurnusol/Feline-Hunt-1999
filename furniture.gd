extends Node2D

class_name furniture

var spawnPlaced = false
var isPlaced = false
var isColliding = false
var collidingArray = []
var value = 5
var displayName = "bar chair"
var texture
var size := Vector2(17, 19)
var puttable = true
var nbtNumber
# Called when the node enters the scene tree for the first time.
func _ready():
	if !spawnPlaced:
		position = get_global_mouse_position()
	var collisionshape2d = CollisionShape2D.new()
	collisionshape2d.shape = RectangleShape2D.new()
	collisionshape2d.shape.size = size
	$area.add_child(collisionshape2d)
	if nbtNumber == null:
		nbtNumber = randf_range(-128, 128)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if texture != null:
		$sprite.texture = load(texture)
		
	if $landCast.is_colliding():
		if $landCast.get_collider().is_in_group("floor"):
			position.y = $landCast.get_collision_point().y - size.y/2
	
	if !isPlaced:
		position.x = get_global_mouse_position().x
		if Input.is_action_just_pressed("interact"):
			scale.x *= -1
		if collidingArray.is_empty():
			modulate = Color(0.667, 1, 1, 0.667)
		else:
			modulate = Color(1, 0.7, 0.7, 0.667)
	else:
		modulate = Color.WHITE
		
	if Input.is_action_just_pressed("left click"):
		if !isPlaced && collidingArray.is_empty() && puttable:
			$AudioStreamPlayer2D.play()
			isPlaced = true
			var pos : Vector2 = global_position
			UnlimitedRulebook.furniturePositionDictionary[displayName + str(nbtNumber)] = [displayName, pos, scale.x, nbtNumber]
			UnlimitedRulebook.furnitureValues += value
			UnlimitedRulebook.isHandFull = false
			UnlimitedRulebook.save_game(UnlimitedRulebook.currSave)
	pass


func _on_area_area_entered(area):
	if area.is_in_group("furnitureArea"):
		collidingArray.append(area)
	pass # Replace with function body.


func _on_area_area_exited(area):
	if area.is_in_group("furnitureArea"):
		collidingArray.pop_back()
	pass # Replace with function body.


func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("left click"):
			if isPlaced && !UnlimitedRulebook.isHandFull:
				spawnPlaced = false
				isPlaced = false
				puttable = false
				$pullTimer.start()
				UnlimitedRulebook.isHandFull = true
				UnlimitedRulebook.furniturePositionDictionary.erase(displayName + str(nbtNumber))
				UnlimitedRulebook.furnitureValues -= value
		if Input.is_action_just_pressed("right click"):
			if isPlaced && !UnlimitedRulebook.isHandFull:
				modulate = Color(1, 0.7, 0.7, 0.667)
				UnlimitedRulebook.furnitureValues -= value
				UnlimitedRulebook.furnitureInventory.append(displayName)
				UnlimitedRulebook.furniturePositionDictionary.erase(displayName + str(nbtNumber))
				UnlimitedRulebook.cafeHud.refresh_items()
				queue_free()
	pass # Replace with function body.


func _on_pull_timer_timeout():
	puttable = true
	pass # Replace with function body.

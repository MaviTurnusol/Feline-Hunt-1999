extends Node2D

@onready var cam = $cam
var camPos := Vector2.ZERO
var camFollowPlayer = false
var destination := Vector2.ZERO
var duration = 1
var direction = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.apartmentScene = self
	if UnlimitedRulebook.enteringFromGarden:
		entering(1, 1, Vector2(-958, 501))
		UnlimitedRulebook.enteringFromGarden = false
	for item in UnlimitedRulebook.furniturePositionDictionary:
		print(UnlimitedRulebook.furniturePositionDictionary[item][1])
		if UnlimitedRulebook.furniturePositionDictionary[item][1] is String:
			UnlimitedRulebook.furniturePositionDictionary[item][1] = string_to_vector2(UnlimitedRulebook.furniturePositionDictionary[item][1])
		Furnituredb.spawn_furniture_placed(UnlimitedRulebook.furniturePositionDictionary[item][0], UnlimitedRulebook.furniturePositionDictionary[item][1])
	pass # Replace with function body.

static func string_to_vector2(string := "") -> Vector2:
	if string:
		var new_string: String = string
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(", ")

		return Vector2(int(array[0]), int(array[1]))

	return Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tween = get_tree().create_tween()
	tween.tween_property(cam, "position", camPos, 0.8)
	
	if camFollowPlayer:
		camPos = UnlimitedRulebook.nonActionPlayer.global_position

func _on_kitchen_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		camPos = Vector2(-314, 43)

func _on_kitchen_area_body_exited(body):
	pass

func _on_corridoor_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		camPos = Vector2(-12, 24)

func _on_corridoor_area_body_exited(body):
	if body.is_in_group("noAcPlayer"):
		camFollowPlayer = false

func _on_window_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		camPos = Vector2(-580, 15)

func _on_window_area_body_exited(body):
	pass


func _on_cafe_interior_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		camPos = Vector2(-207, 461)
	pass # Replace with function body.


func _on_cafe_interior_area_body_exited(body):
	pass # Replace with function body.


func _on_teleport_to_cafe_interior_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		$teleportAnim.play("faded")
		$tpTimer.start()
		destination = Vector2(22, 501)
		duration = 1
		direction = -1
		UnlimitedRulebook.cafeMode = true
	pass # Replace with function body.


func _on_tp_timer_timeout():
	entering(duration, direction, destination)
	pass # Replace with function body.

func entering(dur, dir, des):
	UnlimitedRulebook.nonActionPlayer.era_walk(dur, dir)
	UnlimitedRulebook.nonActionPlayer.global_position = des
	if UnlimitedRulebook.cafeMode:
		$CafeDesignHud.visible = true
	else:
		$CafeDesignHud.visible = false

func _on_teleport_to_house_door_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		$teleportAnim.play("faded")
		$tpTimer.start()
		destination = Vector2(217, 78)
		duration = 1
		direction = -1
		UnlimitedRulebook.cafeMode = false
	pass # Replace with function body.


func _on_book_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
			$bookPuller.play("pull")
	pass # Replace with function body.


func _on_book_area_body_exited(body):
	if body.is_in_group("noAcPlayer"):
		$bookPuller.play_backwards("pull")
	pass # Replace with function body.


func _on_cafe_garden_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		camPos = Vector2(-688, 460)
		if !UnlimitedRulebook.cafeMode:
			UnlimitedRulebook.cafeMode = true
			$CafeDesignHud.visible = true
	pass # Replace with function body.

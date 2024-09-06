extends Node2D

@onready var cam = $cam
var camPos := Vector2.ZERO
var camFollowPlayer = false
var destination := Vector2.ZERO
var duration = 1
var direction = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	camPos = Vector2(-207, 461)
	pass # Replace with function body.


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
	pass # Replace with function body.


func _on_tp_timer_timeout():
	UnlimitedRulebook.nonActionPlayer.era_walk(duration, direction)
	UnlimitedRulebook.nonActionPlayer.global_position = destination
	pass # Replace with function body.


func _on_teleport_to_house_door_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		$teleportAnim.play("faded")
		$tpTimer.start()
		destination = Vector2(217, 78)
		duration = 1
		direction = -1
	pass # Replace with function body.


func _on_book_area_body_entered(body):
	if body.is_in_group("noAcPlayer"):
		$bookPuller.play("pull")
	pass # Replace with function body.


func _on_book_area_body_exited(body):
	if body.is_in_group("noAcPlayer"):
		$bookPuller.play_backwards("pull")
	pass # Replace with function body.

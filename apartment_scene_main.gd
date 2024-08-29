extends Node2D

@onready var cam = $cam
var camPos := Vector2.ZERO
var camFollowPlayer = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tween = get_tree().create_tween()
	tween.tween_property(cam, "position", camPos, 0.8)
	
	if camFollowPlayer:
		camPos = UnlimitedRulebook.nonActionPlayer.global_position

func _on_kitchen_area_body_entered(body):
	camPos = Vector2(-314, 43)

func _on_kitchen_area_body_exited(body):
	pass

func _on_corridoor_area_body_entered(body):
	camPos = Vector2(-12, 24)

func _on_corridoor_area_body_exited(body):
	camFollowPlayer = false

func _on_window_area_body_entered(body):
	camPos = Vector2(-580, 15)

func _on_window_area_body_exited(body):
	pass

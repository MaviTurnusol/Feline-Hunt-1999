extends Node2D

var pouring
@onready var kettle = $kettle/mouth
@onready var cup = $cup
var points : PackedVector2Array

var position_history = []
@export var history_time = 4.0  # How many seconds of history to keep
var update_interval = 0.1  # Store position every 0.1 seconds
var time_passed = 0.0

var coffeeDripX
var cupConnected = false

var firstBeep = false
var failed = false
var failable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBook.changeMusicTo(MusicBook.tutorial)
	$randoTimer.wait_time = randf_range(0.2, 2.4)
	await get_tree().create_timer(5.0).timeout
	$kettleAnimator.play("down")
	$randoTimer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pouring:
		queue_redraw()
		time_passed += delta
		
		if time_passed >= update_interval:
			position_history.append(kettle.global_position.x)
			points.append(Vector2(kettle.global_position.x, kettle.global_position.y))
			time_passed = 0.0
		for i in range(points.size()):
			var currentPoint = points[i]
			currentPoint.y += 80*(4-history_time + 1)*delta
			if points[i].y > 180 && points[i].y < 190:
				coffeeDripX = points[i].x
			points[i] = currentPoint
			
		if points.size() > int(history_time / update_interval):
			position_history.erase(1)
			points.remove_at(1)
		$coffeeLine.points = points
		var tween = get_tree().create_tween()
		tween.tween_property(self, "history_time", 1.0, 10)
		
		if coffeeDripX != null:
			$coffeeDripArea.position.x = coffeeDripX
		if cupConnected:
			pass
	$cup.global_position.x = get_global_mouse_position().x
	$cam.position = (Vector2(240, 135)+Vector2(240, 135)+Vector2(240, 135)+get_global_mouse_position())/4
	pass

func _draw():
	if pouring:
		#draw_polyline(points, Color.BROWN, 10, false)
		pass


func get_pos_secs_ago():
	var framesAgo = int(history_time/update_interval)
	if position_history.size() >= framesAgo:
		return position_history[position_history.size() - framesAgo]
	else:
		return null


func _on_starter_timeout():
	pouring = true
	pass # Replace with function body.


func _on_rando_timer_timeout():
	var randNum = randf_range(2, 3)
	$randoTimer.wait_time = randNum
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property($kettle, "position", Vector2(randf_range(20, 440), 50),randNum)
	$randoTimer.start()
	pass # Replace with function body.


func _on_area_area_entered(area):
	if area.is_in_group("coffee"):
		cupConnected = true
		$cup/openGlow.play("new_animation")
		firstBeep = true
	pass # Replace with function body.


func _on_area_area_exited(area):
	if area.is_in_group("coffee"):
		cupConnected = false
		print(failable)
		if failable:
			failed = true
			$startAnimator.play("end")
		$cup/openGlow.play_backwards("new_animation")
	pass # Replace with function body.


func _on_open_glow_animation_finished(anim_name):
	if firstBeep:
		#failed = true
		pass
	pass # Replace with function body.


func _on_fail_timer_timeout():
	if !cupConnected:
		$startAnimator.play("end")
	failable = true
	pass # Replace with function body.


func _on_start_animator_animation_finished(anim_name):
	if anim_name == "end":
		get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.

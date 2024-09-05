extends CharacterBody2D

var speed = 100.0
var prevState
var state = "walking" : set = set_state
var randStatesArray = ["standing", "checking", "walking", "tired"]
var direction = -1
@onready var anima = $anima
var anim_state = "standing" : set = set_anim
@export var grabValue = 0 : set = set_grabval
@export var tweenVelox = 0
var grabToggled = false
var isBeingGrabbed = false

@onready var stateTimer = $stateTimer

func set_grabval(value):
	if value > 100:
		grabValue = 100
		if state != "tossed":
			state = "tossed"
		return
	else:
		grabValue = value

func set_anim(value):
	if value != anim_state:
		anim_state = value
		anima.play(anim_state)
		
func set_state(value):
	#runs when previous state ends
	if state == "walking":
		velocity.x = 0
		prevState = "walking"
		$sightMarker.scale.x = 1
	if state == "running":
		prevState = "running"
	if state == "checking":
		$sightMarker.scale.x = 1

	#runs when new state starts
	if value == "walking":
		direction = [-1, 1].pick_random()
		stateTimer.wait_time = randf_range(2, 8)
		stateTimer.start()
	if value == "checking":
		stateTimer.wait_time = randf_range(2, 8)
		stateTimer.start()
	if value == "sleeping":
		stateTimer.wait_time = randf_range(6, 20)
		stateTimer.start()
		$sightMarker.scale.x = -direction
	if value == "running":
		direction = sign(global_position.x - UnlimitedRulebook.actionPlayer.global_position.x)
		$sightMarker.scale.x = direction
	if value == "jumping":
		velocity.y -= 320
	if value == "tossed":
		velocity.y -= 625
		$CollisionShape2D.disabled = true
		$sightMarker/sightAreaLarge/CollisionShape2D.disabled = true
		$sightMarker/sightAreaSmall/CollisionShape2D.disabled = true
	state = value

func _ready():
	state = randStatesArray.pick_random()
	stateTimer.wait_time = randf_range(2, 8)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	match state:
		"standing":
			anim_state = "standing"
			velocity.x = 0
			if(stateTimer.is_stopped()): stateTimer.start()
		"walking":
			speed = 50.0
			anima.scale.x = -direction
			$sightMarker.scale.x = direction
			anim_state = "running"
			velocity.x = speed * direction
			if(stateTimer.is_stopped()): stateTimer.start()
		"checking":
			anim_state = "checking"
			velocity.x = 0
			if anima.frame >= 8:
				$sightMarker.scale.x = -1
			else:
				$sightMarker.scale.x = 1
			if(stateTimer.is_stopped()): stateTimer.start()
		"tired":
			velocity.x = 0
			anim_state = "tired"
			if $anima.frame == 9:
				state = "sleeping"
			$sightMarker.scale.x = -direction
		"sleeping":
			anim_state = "sleeping"
		"startled":
			velocity.x = 0
			anim_state = "startled"
			if $anima.frame == 6:
				state = "running"
		"running":
			speed = 140
			anima.scale.x = -direction
			$sightMarker.scale.x = direction
			anim_state = "running"
			velocity.x = speed * direction
			if(stateTimer.is_stopped() && global_position.distance_to(UnlimitedRulebook.actionPlayer.global_position) > 100): stateTimer.start()
			if(global_position.distance_to(UnlimitedRulebook.actionPlayer.global_position) < 100): stateTimer.stop()
			
			if $sightMarker/jumpCast.is_colliding():
				if $sightMarker/jumpCast.get_collider().is_in_group("climbable"):
					stateTimer.stop()
					state = "jumping"
			
			$moveDownTimer.wait_time = randf_range(6, 10)
			if($moveDownTimer.is_stopped()): $moveDownTimer.start()
		"jumping":
			velocity.x = speed * direction
			anim_state = "jumping"
			if is_on_floor() && anima.frame == 2:
				state = prevState
		"tossed":
			anim_state = "jumping"
			if anima.frame == 2:
				anima.pause()
				anima.scale.x += delta * 2
				anima.scale.y += delta * 2
				var tween = get_tree().create_tween()
				tween.tween_property(anima, "rotation_degrees", 360, 0.4)
				stateTimer.stop()
			
	
	$grabBar.value = grabValue
	if isBeingGrabbed:
		if Input.is_action_pressed("interact"):
			if !grabToggled:
				$grabToggle.play("toggle")
				grabToggled = true
			grabValue += delta * 125
			print(grabValue)
		elif Input.is_action_just_released("interact"):
			$grabToggle.play_backwards("toggle")
			grabToggled = false
			var tween = get_tree().create_tween()
			tween.tween_property(self, "grabValue", 0, 0.1)
	elif grabToggled:
		grabToggled = false
		$grabToggle.play_backwards("toggle")
		var tween = get_tree().create_tween()
		tween.tween_property(self, "grabValue", 0, 0.1)


	move_and_slide()


func _on_state_timer_timeout():
	state = randStatesArray.pick_random()
	pass # Replace with function body.


func _on_sight_area_large_body_entered(body):
	if body.is_in_group("AcPlayer"):
		if(!body.isHidden && !body.isStalking):
			if state != "running" && state != "startled" && state != "sleeping":
				state = "startled"
				stateTimer.stop()


func _on_sight_area_small_body_entered(body):
	if body.is_in_group("AcPlayer"):
		if(!body.isHidden):
			if state != "running" && state != "startled":
				state = "startled"
				stateTimer.stop()


func _on_move_down_timer_timeout():
	$moveDownTimer.wait_time = randf_range(6, 10)
	position.y += 1
	pass # Replace with function body.


func _on_grabbable_area_area_entered(area):
	if area.is_in_group("cathingen"):
		$outlineToggle.play("enable")
		isBeingGrabbed = true
	pass # Replace with function body.


func _on_grabbable_area_area_exited(area):
	if area.is_in_group("cathingen"):
		isBeingGrabbed = false
		$outlineToggle.play_backwards("enable")
	pass # Replace with function body.

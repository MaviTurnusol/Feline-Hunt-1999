extends CharacterBody2D

var jumpVel = -400.0
var delayedJump = false
var lapStarted = true
var statis = false

func _physics_process(delta):
	if not is_on_floor():
		if !statis:
			velocity += get_gravity() * delta * 1.2
	if lapStarted:
		if Input.is_action_just_pressed("space") and is_on_floor():
			velocity.y = jumpVel
		if Input.is_action_just_released("space"):
			velocity.y += 200
		
		if Input.is_action_just_pressed("space") and delayedJump:
			velocity.y = jumpVel
			delayedJump = false
		
		if !statis:
			move_and_slide()
		else:
			$anima.pause()
		
		if velocity.y < 0:
			if $anima.animation != "jump":
				$anima.play("jump")
		elif velocity.y > 0:
			if $anima.animation != "fall":
				$anima.play("fall")
		elif is_on_floor():
			$anima.play("run")


func _on_coyote_body_entered(body):
	if body.is_in_group("dreamFloor"):
		delayedJump = true
	pass # Replace with function body.

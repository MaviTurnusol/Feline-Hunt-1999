extends CharacterBody2D

var stamina = 100
var health = 100
var speed = 100.0
var isHidden = false
var isRunning = false
var isClimbing = false
var canRun = true

func _ready():
	UnlimitedRulebook.actionPlayer = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if(velocity.x != 0):
		if isClimbing:
			pass
		elif isRunning:
			$anima.play("run")
		else:
			$anima.play("walking")
		if(velocity.x > 0):
			$anima.flip_h = false
		if(velocity.x < 0):
			$anima.flip_h = true
	else:
		if !isClimbing:
			$anima.play("idle")
	var direction = Input.get_axis("left", "right")
	
	if (Input.is_action_pressed("run") && canRun && direction != 0):
		isRunning = true
	else:
		isRunning = false
	
	if(Input.is_action_just_pressed("down")):
		position.y += 1
	
	if isClimbing:
		speed = 0.0
		if $climbCast.get_collision_point().y >= $posClimb.global_position.y:
			velocity.y = 0
		if $anima.frame == 8:
			speed = 100.0
			position.y -= 40
			isClimbing = false
			$anima.play("idle")
	elif velocity.y > 0:
		if $anima.animation != "fall":
			$anima.play("fall")
	elif velocity.y < 0:
		if $anima.animation != "jump":
			$anima.play("jump")
	if isRunning:
		speed = 150.0
		if stamina > 0:
			stamina -= delta * 16
		else:
			health -= delta * 16
			print(health)
	else:
		speed = 100.0
		if stamina <= 100:
			stamina += delta * 4
		else:
			stamina = 100
	if $climbCast.is_colliding():
		if $climbCast.get_collider().is_in_group("climbable"):
			if Input.is_action_just_pressed("space") && direction == 0 && !isClimbing:
				isClimbing = true
				stamina -= 10
				velocity.y = -400
				$anima.play("climb")
	if !isClimbing && Input.is_action_just_pressed("space") && is_on_floor():
		velocity.y -= 175
	
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

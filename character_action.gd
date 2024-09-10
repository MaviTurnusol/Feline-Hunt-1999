extends CharacterBody2D

var stamina = 100 : set = set_stamina
var speed = 100.0
var isHidden = false
var isRunning = false
var isClimbing = false
var isCatching = false
var isStalking = false
var canRun = true
var canStalk = true
var direction = 0

func set_stamina(value):
	if value < 0:
		UnlimitedRulebook.health += value
		value = 0
		stamina = value
	elif value > 100/6+UnlimitedRulebook.mental*100/6:
		value = 100/6+UnlimitedRulebook.mental*100/6
		stamina = value
	else:
		stamina = value

func _ready():
	UnlimitedRulebook.actionPlayer = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if(velocity.x != 0):
		if isCatching:
			pass
		elif isClimbing:
			pass
		elif isRunning:
			$anima.play("run")
		elif isStalking:
			$anima.play("stalk")
		else:
			$anima.play("walking")
		if(velocity.x > 0):
			$anima.flip_h = false
		if(velocity.x < 0):
			$anima.flip_h = true
	else:
		if !isClimbing && !isCatching:
			$anima.play("idle")
	
	if !isCatching:
		direction = Input.get_axis("left", "right")
	
	if (Input.is_action_pressed("run") && canRun && direction != 0 && !isCatching):
		isRunning = true
	else:
		isRunning = false
		
	if (Input.is_action_pressed("stalk") && canStalk && direction != 0 && !isCatching):
		isStalking = true
	else:
		isStalking = false
	
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
	elif isCatching:
		pass
	elif velocity.y > 0:
		if $anima.animation != "fall":
			$anima.play("fall")
	elif velocity.y < 0:
		if $anima.animation != "jump":
			$anima.play("jump")
	if isRunning:
		speed = 150.0
		stamina -= delta * 16
	elif isStalking:
		speed = 50.0
	else:
		speed = 100.0
		
	if stamina <= 100 && !isRunning:
		stamina += delta * 4
	if stamina > 100:
		stamina = 100
	if $climbCast.is_colliding():
		if $climbCast.get_collider().is_in_group("climbable"):
			if Input.is_action_just_pressed("space") && direction == 0 && !isClimbing && !isCatching:
				isClimbing = true
				stamina -= 10
				velocity.y = -400
				$anima.play("climb")
	if !isClimbing && isRunning && direction != 0 && Input.is_action_just_pressed("space") && !isCatching:
		isCatching = true
		velocity.x = direction * 175
		velocity.y = -50
		stamina -= 10
		$anima.play("catch")
	if isCatching:
		$standingCol.disabled = true
		$catchingCol.disabled = false
		if is_on_floor():
			velocity.x = direction * 75
		else:
			velocity.x = direction * 175
		if $anima.frame == 10:
			isCatching = false
	else:
		$standingCol.disabled = false
		$catchingCol.disabled = true
	
	if !isClimbing && Input.is_action_just_pressed("space") && is_on_floor():
		velocity.y -= 175
	if direction:
		if !isClimbing && !isCatching:
			velocity.x = direction * speed
	else:
		if !isCatching:
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

extends CharacterBody2D


const SPEED = 100.0
var forcedWalk = false

func _ready():
	UnlimitedRulebook.nonActionPlayer = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if(velocity.x != 0):
		$anima.play("walking")
		if(velocity.x > 0):
			$anima.flip_h = false
		if(velocity.x < 0):
			$anima.flip_h = true
	else:
		$anima.play("idle")
	var direction = Input.get_axis("left", "right")
	if !forcedWalk:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		pass

	move_and_slide()

func era_walk(duration, direction):
	forcedWalk = true
	$walkTimer.wait_time = duration
	$walkTimer.start()
	velocity.x = direction * SPEED


func _on_walk_timer_timeout():
	forcedWalk = false
	pass # Replace with function body.

extends CharacterBody2D


var speed = 100.0
var isHidden = false

func _ready():
	UnlimitedRulebook.actionPlayer = self

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
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

extends Node

@onready var menu = $menu
@onready var tutorial = $tutorial
@onready var apartment = $apartment
@onready var street = $street
@onready var shop
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func changeMusicTo(music):
	for item in get_children():
		if item != music:
			var tween = get_tree().create_tween()
			tween.tween_property(item, "volume_db", -80, 2)
			tween.tween_property(item, "playing", false, 0)
	var tween = get_tree().create_tween()
	tween.tween_property(music, "playing", true, 0)
	tween.tween_property(music, "volume_db", -20, -2)

func closeMusic():
	for item in get_children():
		var tween = get_tree().create_tween()
		tween.tween_property(item, "volume_db", -80, 0.3)

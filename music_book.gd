extends Node

@onready var menu = $menu
@onready var tutorial = $tutorial
@onready var apartment = $apartment
@onready var street = $street
@onready var shop
var currentMusic
var musicChangeable = true

var volume = -20 : set = set_volume
var awaitedVolume = -20

func set_volume(value):
	if musicChangeable:
		awaitedVolume = value
		volume = value
		currentMusic.volume_db = value
	else:
		awaitedVolume = value
	
# Called when the node enters the scene tree for the first time.
func _ready():
	currentMusic = $menu
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func changeMusicTo(music):
	musicChangeable = false
	for item in get_children():
		if item != music:
			var tween = get_tree().create_tween()
			tween.tween_property(item, "volume_db", -80, 6)
			tween.tween_property(item, "playing", false, 0)
	currentMusic = music
	var tween = get_tree().create_tween()
	tween.tween_property(music, "playing", true, 0)
	tween.tween_property(music, "volume_db", volume, 6)
	tween.finished.connect(cum)

func cum():
	awaitedVolume = volume
	musicChangeable = true

func closeMusic():
	for item in get_children():
		var tween = get_tree().create_tween()
		tween.tween_property(item, "volume_db", -80, 0.3)


func _on_timer_timeout():
	musicChangeable = true
	pass # Replace with function body.

extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	UnlimitedRulebook.stealthBar = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $bar.value == 100:
		$bar.visible = false
		$anima.visible = true
		$anima.play("default")
		UnlimitedRulebook.actionPlayer.isHidden = true
	pass


func _on_anima_animation_finished():
	UnlimitedRulebook.actionPlayer.isHidden = true
	$anima.stop()
	$anima.visible = false
	pass

func fadin_out():
	var tween = get_tree().create_tween()
	tween.tween_property($bar, "modulate", Color.TRANSPARENT, 0.5)
	UnlimitedRulebook.actionPlayer.isHidden = false

func fadin_in():
	$anima.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property($bar, "modulate", Color.WHITE, 0.5)

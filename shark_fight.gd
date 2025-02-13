extends Node2D

var endGame = false
# Called when the node enters the scene tree for the first time.
func _ready():
	MusicBook.closeMusic()
	print("aosdm")
	DialogueManager.show_dialogue_balloon(load("res://sharkFightDial.dialogue"), "Racon")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StoryBook.sharkTurnRapist:
		$TextureRect.texture = load("res://Sprites/rapeshark.png")
		StoryBook.sharkTurnRapist = false
	if StoryBook.gunpointShark:
		$TextureRect.texture = load("res://Sprites/sharkkilling.png")
		$TextureRect.position.y = -55
		StoryBook.gunpointShark = false
	if StoryBook.nom2:
		$nom2.visible = true
		$nom2.play("default")
		StoryBook.nom2 = false
	if StoryBook.nom3:
		$nom3.visible = true
		$nom3.play("default")
		StoryBook.nom3 = false
	if StoryBook.shoot:
		endGame = true
		$AudioStreamPlayer.play()
		StoryBook.shoot = false
	pass


func _on_nom_2_animation_finished():
	$nom2.visible = false
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_nom_3_animation_finished():
	$nom3.visible = false
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	if endGame:
		get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.

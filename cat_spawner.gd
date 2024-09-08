extends Node2D

var spawnChance = 20
func _ready():
	UnlimitedRulebook.catSpawnerArray.append(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_cat():
	pass

func _on_timer_timeout():
	if global_position.distance_to(UnlimitedRulebook.actionPlayer.global_position) > 570 && global_position.distance_to(UnlimitedRulebook.actionPlayer.global_position) < 1200:
		if randi_range(0, 100) < spawnChance:
			var cat = load("res://gato.tscn").instantiate()
			cat.position = global_position
			UnlimitedRulebook.streetScene.add_child(cat)
			UnlimitedRulebook.catArray.append(cat)
			for spawner in UnlimitedRulebook.catSpawnerArray:
				spawner.spawnChance = 0
		else:
			spawnChance += 1

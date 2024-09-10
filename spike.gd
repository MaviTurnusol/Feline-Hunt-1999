extends Node2D

var speed = 180
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta * speed
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.

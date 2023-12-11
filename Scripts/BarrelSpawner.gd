extends Node2D

@export var incorrect_barrel_scene : PackedScene
@export var correct_barrel_scene : PackedScene

var random = RandomNumberGenerator.new()

var pos1 = Vector2(1100, 300)
var pos2 = Vector2(1100, 50)
var pos3 = Vector2(1100, -200)

func _on_timer_timeout():
	var correct = correct_barrel_scene.instantiate()
	var incorrect1 = incorrect_barrel_scene.instantiate()
	var incorrect2 = incorrect_barrel_scene.instantiate()
	
	var i = random.randi() % 3
	
	if i == 0:
		correct.position = pos1
		incorrect1.position = pos2
		incorrect2.position = pos3
	if i == 1:
		correct.position = pos2
		incorrect1.position = pos1
		incorrect2.position = pos3
	if i == 2:
		correct.position = pos3
		incorrect1.position = pos2
		incorrect2.position = pos1
	get_parent().add_child(correct)
	get_parent().add_child(incorrect1)
	get_parent().add_child(incorrect2)

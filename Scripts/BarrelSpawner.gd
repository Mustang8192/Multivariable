extends Node2D

@export var incorrect_barrel_scene : PackedScene
@export var correct_barrel_scene : PackedScene

var random = RandomNumberGenerator.new()

var pos1 = Vector2(1100, 300)
var pos2 = Vector2(1100, 50)
var pos3 = Vector2(1100, -200)

var question_gen: Node2D

func _ready():
	for child in get_parent().get_children():
		if child.name == "Question":
			question_gen = child
			break

func _on_timer_timeout():
	var correct = correct_barrel_scene.instantiate()
	var incorrect1 = incorrect_barrel_scene.instantiate()
	var incorrect2 = incorrect_barrel_scene.instantiate()
	
	var i = random.randi() % 3
	
	var info: Dictionary
	info = question_gen.generate_question();
	correct.set_label_text(info["answer"])
	incorrect1.set_label_text(info["wrong_1"])
	incorrect2.set_label_text(info["wrong_2"])
	
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

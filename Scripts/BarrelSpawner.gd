extends Node2D

@export var incorrect_barrel_scene : PackedScene
@export var correct_barrel_scene : PackedScene

var random = RandomNumberGenerator.new()

var pos1 = Vector2(1100, 300)
var pos2 = Vector2(1100, 50)
var pos3 = Vector2(1100, -200)

var question_log = []
var question_index = 0

var question_gen: Node2D

func _ready():
	for child in get_parent().get_children():
		if child.name == "Question":
			question_gen = child
			break
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_gen.set_label_text(question_log[0]["text"])

func _on_timer_timeout():
	var correct = correct_barrel_scene.instantiate()
	var incorrect1 = incorrect_barrel_scene.instantiate()
	var incorrect2 = incorrect_barrel_scene.instantiate()
	
	var barrels = Node.new()
	add_child(barrels)
	
	barrels.add_child(correct)
	barrels.add_child(incorrect1)
	barrels.add_child(incorrect2)
	
	var i = random.randi() % 3
	
	if question_log.is_empty():
		question_log.append(question_gen.generate_question())
		question_index = 0
		
	while question_index >= question_log.size():
		question_log.append(question_gen.generate_question())
	var info = question_log[question_index]
	question_index += 1
	
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
	
func next_question():
	question_log.remove_at(0)
	question_log.append(question_gen.generate_question())
	question_gen.set_label_text(question_log[0]["text"])
	question_index -= 1

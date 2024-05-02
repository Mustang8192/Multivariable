extends Node2D

@export var barrel_scene : PackedScene

var random = RandomNumberGenerator.new()

@export var spawn1: Node2D
@export var spawn2: Node2D
@export var spawn3: Node2D

@onready var pos1 = spawn1.position
@onready var pos2 = spawn2.position
@onready var pos3 = spawn3.position

var question_log = []
var question_index = 0

var player: Player
@onready var timer: Timer = %Timer

@onready var question_gen: QuestionGenerator = %Question

var level: int = 0

func _ready():
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_gen.set_label_text(question_log[0]["text"])
	question_gen.current_level += 1

func next_level():
	level += 1
	print("Level transition, new level: " + str(level) + "; Closeness to next curriculum: " + str(level % 3))
	if question_gen.curriculum_data.size() <= question_gen.current_level:
		return
	if level % 3 == 0:
		print("New curriculum!")
		question_gen.current_level += 1

func _on_timer_timeout():
	var correct = barrel_scene.instantiate()
	var incorrect1 = barrel_scene.instantiate()
	var incorrect2 = barrel_scene.instantiate()
	correct.is_correct = true
	incorrect1.is_correct = false
	incorrect2.is_correct = false
	
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

func pause_spawn():
	timer.set_paused(true)

func unpause_spawn():
	timer.set_paused(false)

func set_player(_player: Player):
	player = _player
	player.lives_out.connect(pause_spawn)

func clear_screen():
	for child in get_children():
		if !(child is Timer):
			child.queue_free()
	next_question()

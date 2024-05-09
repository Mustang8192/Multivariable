extends Node2D
class_name BarrelSpawner

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

var check_next_frame: bool = false

func _process(delta):
	if question_log.size() > 0:
		question_gen.set_label_text(question_log[0]["text"])
	else:
		next_question()
	if check_next_frame:
		print("Current barrels: " + str(get_children().map(func(i): return i.get_children().map(func(j): return [j.is_correct, j.name]))))
		check_next_frame = false

func _ready():
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_log.append(question_gen.generate_question())
	question_gen.set_label_text(question_log[0]["text"])
	question_gen.current_level += 1

func next_level():
	level += 1
	if question_gen.curriculum_data.size() <= question_gen.current_level:
		return
	if level % 3 == 0:
		question_gen.current_level += 1

func _on_timer_timeout():
	var correct = barrel_scene.instantiate() as Barrel
	var incorrect1 = barrel_scene.instantiate() as Barrel
	var incorrect2 = barrel_scene.instantiate() as Barrel
	correct.is_correct = true
	incorrect1.is_correct = false
	incorrect2.is_correct = false
	
	correct.next_q.connect(next_question)
	
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

func preload_spawn(positions: Array):
	var correct = barrel_scene.instantiate() as Barrel
	var incorrect1 = barrel_scene.instantiate() as Barrel
	var incorrect2 = barrel_scene.instantiate() as Barrel
	correct.is_correct = true
	incorrect1.is_correct = false
	incorrect2.is_correct = false
	correct.paused = true
	incorrect1.paused = true
	incorrect2.paused = true
	
	
	correct.next_q.connect(next_question)
	
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
		correct.global_position = positions[0]
		incorrect1.global_position = positions[1]
		incorrect2.global_position = positions[2]
	if i == 1:
		correct.global_position = positions[1]
		incorrect1.global_position = positions[0]
		incorrect2.global_position = positions[2]
	if i == 2:
		correct.global_position = positions[2]
		incorrect1.global_position = positions[1]
		incorrect2.global_position = positions[0]
	
	print("!!Current barrels: " + str(get_children().map(func(i): return i.get_children().map(func(j): return [j.is_correct, j.name]))))
	check_next_frame = true

func next_question():
	if question_log.size() > 0:
		question_log.remove_at(0)
		question_index -= 1
	question_log.append(question_gen.generate_question())
	question_gen.set_label_text(question_log[0]["text"])

func pause_spawn():
	timer.set_paused(true)

func unpause_spawn():
	timer.set_paused(false)

func unpause_all_barrels():
	for child in get_children():
		for kid in child.get_children():
			var barrel = kid as Barrel
			barrel.paused = false

func set_player(_player: Player):
	player = _player
	player.lives_out.connect(pause_spawn)

func clear_screen():
	for child in get_children():
		if !(child is Timer):
			child.queue_free()
	question_log = []

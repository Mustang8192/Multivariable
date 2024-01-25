extends Node2D


var body
var json_file_path = "res://Data/curriculums.json"
var curriculum_data
var curriculums = {}
var current_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var json_file = FileAccess.open(json_file_path, FileAccess.READ)
	curriculum_data = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	var i = 0
	for key in curriculum_data:
		curriculums[i] = curriculum_data[key]
		i+=1
	i = 0

func generate_question():
	var current_curriculum = curriculums[current_level]
	#count question types
	var question_count = 0
	for key in current_curriculum:
		question_count+=1
	var question = current_curriculum["question_type_1"] # + str(randi_range(1, question_count))]
	var question_info: Dictionary
	match question["question_type"]:
		"Addition":
			question_info = _questionGenAdd(question["range_one_low"], question["range_one_high"], question["range_two_low"], question["range_two_high"])
		"Subtraction":
			question_info = _questionGenAdd(question["range_one_low"], question["range_one_high"], question["range_two_low"], question["range_two_high"])
		"Division":
			question_info = {
				"answer": "division"
			}
	print(question["question_type"])
	return question_info

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _questionGenAdd(rand1_low, rand1_high, rand2_low, rand2_high):
	print("Generating New Problem")
	var val1 = randi_range(rand1_low, rand1_high)
	var val2 = randi_range(rand2_low, rand2_high)
	var text: String
	
	var answer = val1 + val2

	text = str(val1) + " + " + str(val2) + " ="
	
	var wrong1 = val1
	var wrong2 = val1
	
	while wrong1 == val1 or wrong1 == val2:
		wrong1 = randi_range(rand1_low, rand1_high)
	while wrong2 == val1 or wrong2 == val2 or wrong2 == wrong1:
		wrong2 = randi_range(rand1_low, rand1_high)
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}


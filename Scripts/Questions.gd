extends RichTextLabel


var body
var json_file_path = "res://Data/curriculums.json"
var curriculum_data
var curriculums = {}
var current_level = 2

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
	var question_count = 1
	for key in current_curriculum:
		question_count+=1
	var question = current_curriculum["question_type_" + str(randi_range(1, question_count))]
	var question_info
	match question["question_type"]:
		"Addition":
			question_info = _questionGenAdd(question["range_one_low"], question["range_one_high"], question["range_two_low"], question["range_two_high"])
		"Subtraction":
			question_info = _questionGenAdd(question["range_one_low"], question["range_one_high"], question["range_two_low"], question["range_two_high"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _questionGenAdd(rand1_low, rand1_high, rand2_low, rand2_high):
	print("Generating New Problem")
	var val1 = randi_range(rand1_low, rand1_high)
	var val2 = randi_range(rand2_low, rand2_high)

	text = str(val1) + "+" + str(val2)
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2
	}


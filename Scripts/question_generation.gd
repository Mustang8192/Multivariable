extends Node2D
class_name QuestionGenerator

var body
var json_file_path = "res://Data/curriculums.json"
var curriculum_data
var curriculums = {}
var current_level = 0
var random_curriculum: bool = false

var label: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	get_label_node()
	var json_file = FileAccess.open(json_file_path, FileAccess.READ)
	curriculum_data = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	var i = 0
	for key in curriculum_data:
		curriculums[i] = curriculum_data[key]
		i+=1
	i = 0

func get_label_node():
	for child in get_children():
		if child is RichTextLabel:
			label = child
			break

func generate_question():
	if current_level >= curriculums.size():
		random_curriculum = true
	var current_curriculum = curriculums[current_level] if !random_curriculum else curriculums[randi_range(0, curriculums.size() - 1)]
	#count question types
	var question_count = 0
	for key in current_curriculum:
		question_count+=1
	var question: Question = Question.new(current_curriculum["question_type_" + str(randi_range(1, question_count))])
	var question_info: Dictionary
	match question.type:
		"Addition":
			question_info = questionGenAdd(question)
		"Subtraction":
			question_info = questionGenSubtract(question)
		"Division":
			question_info = questionGenDivide(question)
		"Multiplication":
			question_info = questionGenMultiply(question)
		"Fraction Simplify":
			question_info = questionGenFractionSimplify(question)
		"Fraction Conversion":
			question_info = questionGenFractionConversion(question)
		"Rounding":
			question_info = questionGenRound(question)
		"Comparing":
			question_info = questionGenCompare(question)
		"Conversion":
			question_info = questionGenConvertUnits(question)
	return question_info

func questionGenAdd(question: Question):
	print("Generating Addition Problem")
	var val1 = question.random_val1()
	var val2 = question.random_val2()
	var text: String
	
	var answer = val1 + val2

	text = str(val1) + " + " + str(val2) + " ="
	
	var wrong1 = answer
	var wrong2 = answer
	
	while wrong1 == answer:
		wrong1 = question.random_val1() + question.random_val2()
	while wrong2 == answer or wrong2 == wrong1:
		wrong2 = question.random_val1() + question.random_val2()
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}
	
func questionGenSubtract(question: Question):
	print("Generating Subtraction Problem")
	var val1 = question.random_val1()
	var val2 = question.random_val2()
	var text: String
	
	var answer = val1 - val2

	text = str(val1) + " - " + str(val2) + " ="
	
	var wrong1 = answer
	var wrong2 = answer
	
	while wrong1 == answer:
		wrong1 = question.random_val1() - question.random_val2()
	while wrong2 == answer or wrong2 == wrong1:
		wrong2 = question.random_val1() - question.random_val2()
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}

func questionGenDivide(question: Question):
	print("Generating Division Problem")
	var divisor = question.random_val1()
	var quotient = question.random_val2()
	var text: String
	
	var dividend = divisor * quotient

	text = str(dividend) + " ÷ " + str(divisor) + " ="
	
	var wrong1 = quotient
	var wrong2 = quotient
	
	while wrong1 == quotient:
		wrong1 = question.random_val1()
	while wrong2 == quotient or wrong2 == wrong1:
		wrong2 = question.random_val1()
	
	print(str(text))
	return {
		"text": text,
		"value_1": dividend,
		"value_2": divisor,
		"answer": str(quotient),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}
	
func questionGenMultiply(question: Question):
	print("Generating Multiplication Problem")
	var val1 = question.random_val1()
	var val2 = question.random_val2()
	var text: String
	
	var answer = val1 * val2

	text = str(val1) + " X " + str(val2) + " ="
	
	var wrong1 = answer
	var wrong2 = answer
	
	while wrong1 == answer:
		wrong1 = question.random_val1() * question.random_val2()
	while wrong2 == answer or wrong2 == wrong1:
		wrong2 = question.random_val1() * question.random_val2()
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}
	
func questionGenFractionSimplify(question: Question):
	print("Generating Fraction Simplification Problem")
	var val1 = question.random_val2()
	var val2 = question.random_val2()
	var multi = question.random_mult()
	var text: String
	
	print("Value 1: " + str(val1))
	print("Value 2: " + str(val2))
	print("Multiplier: " + str(multi))
	
	var i = 2
	while i <= 10:
		if val1 % i == 0 and val2 % i == 0:
			val1 = val1/i
			val2 = val2/i
		i += 1
	
	var answer = str(val1) + "/" + str(val2)

	text = "Simplify the fraction " + str(val1*multi) + "/" + str(val2*multi)
	
	var wrong1 = str(val1) + "/" + str(val2)
	var wrong2 = str(val1) + "/" + str(val2)
	
	var wrong1_val1 = question.random_val1()
	var wrong1_val2 = question.random_val1()
	var wrong2_val1 = question.random_val1()
	var wrong2_val2 = question.random_val1()
	
	while wrong1 == answer or wrong1_val1/wrong1_val2 == val1/val2:
		wrong1_val1 = question.random_val1()
		wrong1_val2 = question.random_val1()
		wrong1 = str(wrong1_val1) + "/" + str(wrong1_val2)
	while wrong2 == answer or wrong2_val1/wrong2_val2 == wrong1_val1/wrong1_val2 or wrong2_val1/wrong2_val2 == val1/val2:
		wrong2_val1 = question.random_val1()
		wrong2_val2 = question.random_val1()
		wrong2 = str(wrong2_val1) + "/" + str(wrong2_val2)
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": answer,
		"wrong_1": wrong1,
		"wrong_2": wrong2
	}
	
func questionGenFractionConversion(question: Question):
	print("Generating Fraction Conversion Problem")
	var type = randi_range(0,1) #0 means mixed number to improper fraction, 1 means improper to mixed
	
	# val1 will be the larger number and the numerator; val2 will be smaller, the denominator
	var val1 = question.random_val1()
	var val2 = question.random_val2()
	
	while val1 == val2:
		val2 = question.random_val2()
	
	if val1 < val2:
		var temp = val1
		val1 = val2
		val2 = temp
	
	print("Value 1: " + str(val1))
	print("Value 2: " + str(val2))
	
	var i = 2
	while i <= 10:
		while val1 % i == 0 and val2 % i == 0:
			val1 = val1/i
			val2 = val2/i
		i += 1
		
	var remainder = val1 % val2
	var full_number: int
	if round(val1/val2) > val1/val2:
		full_number = round(val1/val2) - 1
	else:
		full_number = round(val1/val2)
	
	var improper: String = str(val1) + "/" + str(val2)
	var mixed: String = str(full_number) + " " + str(remainder) + "/" + str(val2)
	
	if val1/val2 != full_number + (remainder/val2):
		print("Somethings wrong")
	
	var answer: String
	var text: String
	
	match type:
		0:
			print("Mixed -> improper")
			answer = improper
			text = "Convert " + mixed + " into an improper fraction"
		1: 
			print("Improper -> Mixed")
			answer = mixed
			text = "Convert " + improper + " into a mixed number"
	

	var wrong1_val1 = val1
	var wrong1_val2 = val2
	var wrong2_val1 = val1
	var wrong2_val2 = val2
	
	var wrong1 = answer
	var wrong2 = answer
	
	while wrong1_val1/wrong1_val2 == val1/val2:
		wrong1_val1 = question.random_val1()
		wrong1_val2 = question.random_val2()
		while wrong1_val1 == wrong1_val2:
			wrong1_val2 = question.random_val2()
		if wrong1_val1 < wrong1_val2:
			var temp = wrong1_val1
			wrong1_val1 = wrong1_val2
			wrong1_val2 = temp
	while wrong2_val1/wrong2_val2 == wrong1_val1/wrong1_val2 or wrong2_val1/wrong2_val2 == val1/val2:
		wrong2_val1 = question.random_val1()
		wrong2_val2 = question.random_val2()
		while wrong2_val1 == wrong2_val2:
			wrong2_val2 = question.random_val2()
		if wrong2_val1 < wrong2_val2:
			var temp = wrong2_val1
			wrong2_val1 = wrong2_val2
			wrong2_val2 = temp
	
	match type:
		0:
			wrong1 = str(wrong1_val1) + "/" + str(wrong1_val2)
			wrong2 = str(wrong2_val1) + "/" + str(wrong2_val2)
		1:
			remainder = wrong1_val1 % wrong1_val2
			if round(wrong1_val1/wrong1_val2) > wrong1_val1/wrong1_val2:
				full_number = round(wrong1_val1/wrong1_val2) - 1
			else:
				full_number = round(wrong1_val1/wrong1_val2)
			wrong1 = str(full_number) + " " + str(remainder) + "/" + str(wrong1_val2)
			remainder = wrong2_val1 % wrong2_val2
			if round(wrong2_val1/wrong2_val2) > wrong2_val1/wrong2_val2:
				full_number = round(wrong2_val1/wrong2_val2) - 1
			else:
				full_number = round(wrong2_val1/wrong2_val2)
			wrong2 = str(full_number) + " " + str(remainder) + "/" + str(wrong2_val2)
	
	return {
		"text": text,
		"value_1": val1,
		"value_2": val2,
		"answer": answer,
		"wrong_1": wrong1,
		"wrong_2": wrong2
	}

func questionGenRound(question: Question):
	print("Generating Rounding Problem")
	var val1 = round(question.randf_val1() * 10)/10
	var text: String
	
	var answer = round(val1)

	text = "Round " + str(val1) + " to the nearest 1: "
	
	var wrong1 = answer + 1
	var wrong2 = answer - 1
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": 0,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}

func questionGenCompare(question: Question):
	print("Generating Comparison Problem")
	var val1 = round(question.randf_val1() * 10)/10
	var val2 = round(question.randf_val2() * 10)/10
	var text: String
	

	text = "Is " + str(val1) + " greater than, less than, or equal to " + str(val2)
	
	var answer = ("=" if val1 == val2
	else ">" if val1 > val2
	else "<" if val1 < val2
	else "I'm the right one!")
	var wrong1 = (">" if answer == "=" else "=")
	var wrong2 = ("<" if answer != "<" else ">")
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": 0,
		"answer": answer,
		"wrong_1": wrong1,
		"wrong_2": wrong2
	}

func questionGenConvertUnits(question: Question):
	print("Generating Unit Conversion Problem")
	var answer = question.random_val1()

	var val1 = answer * question.conversion_factor

	var text: String = "Convert " + str(val1) + " " + question.units_in + " to " + question.units_to
	
	var wrong1 = question.random_val1()
	var wrong2 = question.random_val1()
	
	while wrong1 == answer:
		wrong1 = question.random_val1()
	while wrong2 == answer or wrong2 == wrong1:
		wrong2 = question.random_val1()
	
	print(str(text))
	return {
		"text": text,
		"value_1": val1,
		"value_2": 0,
		"answer": str(answer),
		"wrong_1": str(wrong1),
		"wrong_2": str(wrong2)
	}

func set_label_text(text: String):
	label.set_text(text)


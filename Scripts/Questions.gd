extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Generating New Problem")
	var type = randi_range(1,2)
	var val1 = 0
	var val2 = 0
	if(type == 1):
		val1 = randi_range(0,12)
		val2 = randi_range(1,12)
		text = str(val1) + "X" + str(val2)
	elif (type == 2):
		val1 = randi_range(1,12)
		var perfectsqrs = [0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225]
		var intsqrs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
		
		text = str(val1) + "/" + str(val2)
		
	print(str(text))
		#add_child(text)


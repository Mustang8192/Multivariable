extends RichTextLabel


var body
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _questionGenAdd():
	print("Generating New Problem")
	var val1 = randi_range(0,12)
	var val2 = randi_range(1,12)

	text = str(val1) + "+" + str(val2)
		
	print(str(text))
		#add_child(text)


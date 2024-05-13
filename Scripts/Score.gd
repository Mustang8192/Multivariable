extends RichTextLabel

@onready var level: Level = get_parent() as Level
var score: int = 0

func increaseScore():
	score+=100
	
func _ready():
	level.level_transition.connect(increaseScore)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Score: " + str(score)

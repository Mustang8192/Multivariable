extends RichTextLabel

var player

func _ready():
	player = get_tree().root.get_child(0).get_node("Player")

func _process(delta):
	text = "Lives: " + str(player.get_meta("lives"))

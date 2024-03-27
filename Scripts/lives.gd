extends RichTextLabel
class_name LivesCounter

var player: Player

func set_player(_player: Player):
	player = _player

func _process(delta):
	if player == null:
		return
	text = "Lives: " + str(player.get_meta("lives"))

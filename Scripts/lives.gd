extends RichTextLabel
class_name LivesCounter

var player: Player

func set_player(_player: Player):
	player = _player

func _process(delta):
	if player == null:
		return
	if player.get_meta("lives") == 3:
		text = "❤️❤️❤️"
	if player.get_meta("lives") == 2:
		text = "❤️❤️🖤"
	if player.get_meta("lives") == 1:
		text = "❤️🖤🖤"

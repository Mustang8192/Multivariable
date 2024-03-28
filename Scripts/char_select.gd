extends Control

signal back_to_main
signal character_select

var char_index: int
var sprites: Array[CSSprite]

func child_get(child: CSSprite):
	sprites[child.id] = child

func _process(delta):
	for sprite in sprites:
		var value = sprite.id - char_index
		if value < 0:
			value+=5
		match value:
			0:
				pass #center
			1:
				pass #right mid
			2:
				pass #far right
			3:
				pass #far left
			4:
				pass #left middle
		



func _on_back_button_down():
	back_to_main.emit()


func _on_select_button_down():
	character_select.emit(char_index)


func _on_right_button_down():
	char_index+=1
	if char_index > 4:
		char_index = 0


func _on_left_button_down():
	char_index-=1
	if char_index < 0:
		char_index = 4

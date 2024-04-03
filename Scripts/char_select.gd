extends Control

signal back_to_main
signal character_select

var char_index: int
var sprites: Array[Sprite2D] = [null, null, null, null, null]

@export var sprite_positions: Array[Node2D]
@export var char_label: Label

func child_get(child: Sprite2D):
	sprites[child.id] = child

func _process(delta):
	match char_index:
		0:
			char_label.text = "mario"
		1:
			char_label.text = "toad"
		2:
			char_label.text = "peach"
		3:
			char_label.text = "koopa"
		4:
			char_label.text = "bowser"
	for sprite in sprites:
		var value = sprite.id - char_index
		if value < 0:
			value+=5
		match value:
			0:
				sprite.position = sprite_positions[2].position
			1:
				sprite.position = sprite_positions[3].position
			2:
				sprite.position = sprite_positions[4].position
			3:
				sprite.position = sprite_positions[0].position
			4:
				sprite.position = sprite_positions[1].position
		



func _on_back_button_down():
	back_to_main.emit()


func _on_select_button_down():
	character_select.emit(char_index)
	back_to_main.emit()


func _on_right_button_down():
	char_index+=1
	if char_index > 4:
		char_index = 0


func _on_left_button_down():
	char_index-=1
	if char_index < 0:
		char_index = 4

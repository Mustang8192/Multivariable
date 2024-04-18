extends Control

@export var screen_1: Sprite2D
@export var screen_2: Sprite2D

signal back_to_main()

func _on_button_down():
	if screen_1.visible:
		screen_1.hide()
	else:
		back_to_main.emit()

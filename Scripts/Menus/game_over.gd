extends Control

signal back_to_main

@export var label: RichTextLabel
var text
var score

func _on_back_to_main_menu_button_down():
	back_to_main.emit()


func _process(delta):
	text = "Score: " + str(score)
	label.text = text

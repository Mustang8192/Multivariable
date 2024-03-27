extends Control
class_name MainMenu

signal start_game()
signal go_to_tutorial()
signal go_to_char_select()

@export var level_scene: PackedScene

func _on_start_button_down():
	start_game.emit()
	hide()


func _on_character_select_button_down():
	go_to_char_select.emit()
	hide()


func _on_tutorial_button_down():
	go_to_tutorial.emit()
	hide()

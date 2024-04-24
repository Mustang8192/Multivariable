extends Control

signal back_to_main

func _on_back_to_main_menu_button_down():
	back_to_main.emit()

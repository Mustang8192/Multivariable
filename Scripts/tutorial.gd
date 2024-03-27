extends Control

signal back_to_main()

func _on_back_button_down():
	back_to_main.emit()

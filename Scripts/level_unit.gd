extends Sprite2D
class_name LevelUnit

signal transition

@export var preload_spawns: Node2D

func _on_transition__trigger_body_entered(body):
	print("Transition trigger entered")
	if !(body is Player):
		return
	print("Sending transition signal")
	transition.emit(self)

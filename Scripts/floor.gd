extends StaticBody2D
class_name Floor

@export var barrier: CollisionShape2D

func toggle_barrier():
	barrier.disabled = !barrier.disabled

func enable_barrier():
	barrier.disabled = false

func disable_barrier():
	barrier.disabled = true

extends CharacterBody2D


const SPEED = 100.0

var direction = -1
var label: Label

func get_label_node():
	for child in get_children():
		if child is Label:
			label = child
			break

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y = SPEED + 50


	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_label_text(text: String):
	get_label_node()
	label.set_text(text)

extends CharacterBody2D
class_name Barrel

const SPEED = 700.0

var label

var paused: bool = false

var is_correct: bool
signal next_q

func get_label_node():
	for child in get_children():
		if child is Label:
			label = child
			break

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y = SPEED + 50

	if is_on_floor() and !paused:
		var floor_normal = get_floor_normal()  # Get the normal vector of the floor
		var slope_angle = atan2(floor_normal.x, floor_normal.y)  # Calculate the angle of the slope

		# Adjust the slope angle to point downward
		if slope_angle > PI / 2:
			slope_angle -= PI

		# Calculate the horizontal velocity based on the slope angle
		velocity.x = SPEED * cos(slope_angle)
		velocity.y = SPEED * sin(slope_angle)

	else:
		velocity.x = 0  # No horizontal movement when not on the floor

	move_and_slide()

func set_label_text(text: String):
	get_label_node()
	label.set_text(text)


func _on_barrier_detection_body_entered(body):
	if paused:
		return
	if body.name.begins_with("Barrier"):
		if is_correct:
			next_q.emit()
		queue_free()

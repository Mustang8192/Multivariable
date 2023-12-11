extends CharacterBody2D

const SPEED = 100.0

var direction = -1

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

extends CharacterBody2D
const Generator = preload("res://Scripts/Questions.gd")
var questions = Generator.new()

const SPEED = 400.0
const JUMP_VELOCITY = -400.0


var gravity = 980
var lives = 3

func _process(delta):
	set_meta("lives", lives)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_incorrect_barrel_body_entered(body):
	if body.get_meta("type") == "correct_barrel":
		lives -= 1
		questions._questionGenAdd()
		body.queue_free()
	if body.get_meta("type") == "incorrect_barrel":
		body.queue_free()
		questions._questionGenAdd()
	if lives <= 0:
		get_parent().queue_free()



func _on_correct_barrel_body_entered(body):
	if body.get_meta("type") == "correct_barrel":
		body.queue_free()
		questions._questionGenAdd()
	if body.get_meta("type") == "incorrect_barrel":
		lives -= 1
		body.queue_free()
	if lives <= 0:
		get_parent().queue_free()

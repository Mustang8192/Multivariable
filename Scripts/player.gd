extends CharacterBody2D
const Generator = preload("res://Scripts/Questions.gd")
var questions = Generator.new()

const SPEED = 200.0
const JUMP_VELOCITY = -400.0


var gravity = 980
var lives = 3

#var on_floor_last_tick : bool
var time_since_ground : float

func _process(delta):
	set_meta("lives", lives)

func _physics_process(delta):
	# Add the gravity.

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor() or time_since_ground < 0.1:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if is_on_floor():
		#on_floor_last_tick = true
		time_since_ground = 0
			
	if not is_on_floor():
		velocity.y += gravity * delta
		time_since_ground += delta
		#on_floor_last_tick = false

	move_and_slide()

func _on_incorrect_barrel_body_entered(body):
	if body.get_meta("type") == "correct_barrel":
		lives -= 1
		#questions.generate_question()
		body.queue_free()
	if body.get_meta("type") == "incorrect_barrel":
		body.queue_free()
		#questions.generate_question()
	if lives <= 0:
		get_parent().queue_free()



func _on_correct_barrel_body_entered(body):
	if body.get_meta("type") == "correct_barrel":
		body.queue_free()
		#questions.generate_question()
	if body.get_meta("type") == "incorrect_barrel":
		lives -= 1
		body.queue_free()
	if lives <= 0:
		get_parent().queue_free()

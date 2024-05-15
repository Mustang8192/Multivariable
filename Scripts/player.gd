extends CharacterBody2D
class_name Player
#const Generator = preload("res://Scripts/question_generation.gd")
#var questions = Generator.new()

const SPEED = 500.0
const JUMP_VELOCITY = -700.0

var gravity = 980
var lives = 3

var paused: bool = false

var barrel_spawner

signal lives_out

var time_since_ground : float

var char_index: int = -1
var animated_sprite: AnimatedSprite2D

var current_floor: Floor
var previous_floor: Floor

var score: int

@export var mario_sprites: SpriteFrames
@export var toad_sprites: SpriteFrames
@export var peach_sprites: SpriteFrames
@export var koopa_sprites: SpriteFrames
@export var bowser_sprites: SpriteFrames

@export var mario_scale: Vector2 = Vector2(.099, .093)
@export var toad_scale: Vector2 = Vector2(.033, .027)
@export var peach_scale: Vector2 = Vector2(.068, .054)
@export var koopa_scale: Vector2 = Vector2(.035, .03)
@export var bowser_scale: Vector2 = Vector2(.099, .093)

func enter():
	set_meta("lives", 3)
	lives = 3
	animated_sprite = %AnimatedSprite2D
	print(char_index)
	match char_index:
		0:
			animated_sprite.set_sprite_frames(mario_sprites)
			animated_sprite.scale = mario_scale
		1:
			animated_sprite.set_sprite_frames(toad_sprites)
			animated_sprite.scale = toad_scale
		2:
			animated_sprite.set_sprite_frames(peach_sprites)
			animated_sprite.scale = peach_scale
		3:
			animated_sprite.set_sprite_frames(koopa_sprites)
			animated_sprite.scale = koopa_scale
		4:
			animated_sprite.set_sprite_frames(bowser_sprites)
			animated_sprite.scale = bowser_scale
	animated_sprite.animation = "stand"

func _process(delta):
	set_meta("lives", lives)

func _physics_process(delta):
	# Add the gravity.
	if paused:
		velocity.x = 0
		position.y += 20
		move_and_slide()
		return

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor() or time_since_ground < 0.1:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if direction < 0:
				animated_sprite.flip_h = true
				if animated_sprite.get_sprite_frames() == bowser_sprites:
					animated_sprite.flip_h = false
			else:
				animated_sprite.flip_h = false
				if animated_sprite.get_sprite_frames() == bowser_sprites:
					animated_sprite.flip_h = true
			animated_sprite.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animated_sprite.play("stand")
	
	if is_on_floor():
		#on_floor_last_tick = true
		time_since_ground = 0
			
	if not is_on_floor():
		velocity.y += gravity * delta
		time_since_ground += delta
		animated_sprite.play("jump")

	move_and_slide()

func pause():
	paused = true
	velocity.y = 0

func unpause():
	paused = false

func _on_incorrect_barrel_body_entered(body):
	if !(body is Barrel):
		return
	var barrel = body as Barrel
	if barrel.paused:
		return
	if barrel.is_correct:
		lives -= 1
		barrel_spawner = barrel.get_parent().get_parent()
		barrel_spawner.next_question()
		var barrels = body.get_parent()
		for node in barrels.get_children():
			node.queue_free()
		barrels.queue_free()
	if !barrel.is_correct:
		body.queue_free()
	if lives <= 0:
		lives_out.emit(score)



func _on_correct_barrel_body_entered(body):
	if !(body is Barrel) and !(body is StaticBody2D):
		return
	if body is Barrel:
		var barrel = body as Barrel
		if barrel.paused:
			return
		if !barrel.is_correct:
			lives -= 1
			body.queue_free()
		if barrel.is_correct:
			barrel_spawner = barrel.get_parent().get_parent()
			barrel_spawner.next_question()
			var barrels = body.get_parent()
			for node in barrels.get_children():
				node.queue_free()
			barrels.queue_free()
		if lives <= 0:
			lives_out.emit(score)
	if body is Floor:
		var floor = body as Floor
		if floor != current_floor:
			previous_floor = current_floor
			current_floor = floor
			floor.call_deferred("enable_barrier")


extends Node2D
class_name Level

var player: Player
@onready var barrel_spawner = %BarrelSpawner
@onready var question_gen = %Question
@onready var lives_counter: LivesCounter = %"Lives Counter"

@onready var environment = %environment
@export var active_unit: LevelUnit
@export var level_unit_scene: PackedScene

signal game_over

func _process(delta):
	if lives_counter.player && barrel_spawner.player:
		return
	if player:
		lives_counter.set_player(player)
		barrel_spawner.set_player(player)
		return
	active_unit.transition.connect(screen_transition)
	for unit in environment.get_children():
		unit.transition.connect(screen_transition)

func screen_transition():
	print("Level transition")
	environment.position += Vector2(0, -850)
	var new_unit = level_unit_scene.instantiate()
	new_unit.position = Vector2(0,1572)
	environment.add_child(new_unit)

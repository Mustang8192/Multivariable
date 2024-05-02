extends Node2D
class_name Level

var player: Player
@onready var barrel_spawner = %BarrelSpawner
@onready var question_gen = %Question
@onready var lives_counter: LivesCounter = %"Lives Counter"

@onready var environment = %environment
@export var active_unit: LevelUnit
@export var level_unit_scene: PackedScene
@export var units: Array[LevelUnit]

var environment_moving: bool = false
var environment_goal_y: float
var environment_speed: float = 5.0

signal level_transition
signal game_over

func _ready():
	level_transition.connect(barrel_spawner.next_level)

func _process(delta):
	for child in environment.get_children():
		var unit = child as LevelUnit
		if !unit.transition.is_connected(screen_transition):
			unit.transition.connect(screen_transition)
	if environment_moving && environment.position.y != environment_goal_y:
		environment.position.y += environment_speed
		if environment.position.y >= environment_goal_y:
			environment_stop()
	if lives_counter.player && barrel_spawner.player:
		return
	if player:
		lives_counter.set_player(player)
		barrel_spawner.set_player(player)
		return
	active_unit.transition.connect(screen_transition)


func screen_transition(unit: LevelUnit):
	if unit != active_unit:
		return
	level_transition.emit()
	var new_unit = level_unit_scene.instantiate()
	new_unit.position = units[0].position + Vector2(0, -1572)
	units.insert(0, new_unit)
	active_unit = new_unit
	environment.add_child(new_unit)
	environment_goal_y = environment.position.y + 1572
	environment_move()

func environment_move():
	barrel_spawner.pause_spawn()
	environment_moving = true
	player.pause()
	barrel_spawner.clear_screen()

func environment_stop():
	environment_moving = false
	barrel_spawner.unpause_spawn()
	player.unpause()

extends Node2D
class_name Level

var player: Player
@onready var barrel_spawner = %BarrelSpawner
@onready var question_gen = %Question
@onready var lives_counter: LivesCounter = %"Lives Counter"

func _ready():
	if player == null:
		print("Player not found")
		return
	lives_counter.set_player(player)

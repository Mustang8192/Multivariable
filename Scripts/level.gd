extends Node2D
class_name Level

var player: Player
@onready var barrel_spawner = %BarrelSpawner
@onready var question_gen = %Question
@onready var lives_counter: LivesCounter = %"Lives Counter"

signal game_over

func _process(delta):
	if lives_counter.player && barrel_spawner.player:
		return
	if player:
		lives_counter.set_player(player)
		barrel_spawner.set_player(player)
		return

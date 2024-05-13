extends Node2D

@onready var UI: CanvasLayer = %UI

@export var level_scene: PackedScene
@export var player_scene: PackedScene
@export var main_menu_scene: PackedScene
@export var tutorial_scene: PackedScene
@export var char_select_scene: PackedScene
@export var game_over_scene: PackedScene
@export var credits_scene: PackedScene

var level: Level
var player: Player
var main_menu: MainMenu
var tutorial_screen
var char_select_screen
var game_over_screen
var credits_screen

var current_screen

var char_index: int

signal level_loaded()

func _ready():
	instantiate_main_menu()

func instantiate_main_menu():
	main_menu = main_menu_scene.instantiate()
	main_menu.start_game.connect(instantiate_level)
	main_menu.go_to_char_select.connect(show_char_select)
	main_menu.go_to_tutorial.connect(show_tutorial)
	main_menu.go_to_credits.connect(show_credits)
	UI.add_child(main_menu)
	current_screen = main_menu
	
func instantiate_level():
	level = level_scene.instantiate()
	add_child(level)
	level.position = Vector2(0,0)
	player = player_scene.instantiate()
	player.scale = Vector2(3,3)
	player.position = Vector2(164,1490)
	level.add_child(player)
	level.player = player
	level.player.lives_out.connect(game_over)
	level.player.char_index = char_index
	level_loaded.connect(level.player.enter)
	current_screen = level
	level_loaded.emit()

func show_char_select():
	main_menu.queue_free()
	char_select_screen = char_select_scene.instantiate()
	UI.add_child(char_select_screen)
	char_select_screen.back_to_main.connect(back_to_main)
	char_select_screen.character_select.connect(select_character)
	char_select_screen.char_index = char_index
	current_screen = char_select_screen
	
func show_tutorial():
	main_menu.queue_free()
	tutorial_screen = tutorial_scene.instantiate()
	UI.add_child(tutorial_screen)
	tutorial_screen.back_to_main.connect(back_to_main)
	current_screen = tutorial_screen

func show_game_over():
	game_over_screen = game_over_scene.instantiate()
	UI.add_child(game_over_screen)
	game_over_screen.back_to_main.connect(back_to_main)
	current_screen = game_over_screen

func show_credits():
	main_menu.queue_free()
	credits_screen = credits_scene.instantiate()
	UI.add_child(credits_screen)
	credits_screen.back_to_main.connect(back_to_main)
	current_screen = credits_screen

func back_to_main():
	if tutorial_screen:
		tutorial_screen.queue_free()
		tutorial_screen = null
	if char_select_screen:
		char_select_screen.queue_free()
		char_select_screen = null
	if game_over_screen:
		game_over_screen.queue_free()
		game_over_screen = null
	if level:
		level.queue_free()
		level = null
	if credits_screen:
		credits_screen.queue_free()
		credits_screen = null
	instantiate_main_menu()
	current_screen = main_menu

func game_over():
	if not level:
		print("Game over without level loaded!")
		return
	
	level.player.queue_free()
	show_game_over()
	
func select_character(index):
	char_index = index as int

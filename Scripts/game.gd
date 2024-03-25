extends Node2D

@onready var UI: CanvasLayer = %UI

@export var level_scene: PackedScene
@export var player_scene: PackedScene
@export var main_menu_scene: PackedScene
@export var tutorial_scene: PackedScene
@export var char_select_scene: PackedScene

var level: Level
var player: Player
var main_menu: MainMenu
var tutorial_screen
var char_select_screen


func _ready():
	instantiate_main_menu()

func instantiate_main_menu():
	main_menu = main_menu_scene.instantiate()
	main_menu.start_game.connect(instantiate_level)
	main_menu.go_to_char_select.connect(show_char_select)
	main_menu.go_to_tutorial.connect(show_tutorial)
	UI.add_child(main_menu)
	
func instantiate_level():
	level = level_scene.instantiate()
	add_child(level)
	level.position = Vector2(0,0)
	player = player_scene.instantiate()
	player.scale = Vector2(3,3)
	player.position = Vector2(304, 500)
	level.add_child(player)
	level.player = player

func show_char_select():
	main_menu.queue_free()
	char_select_screen = char_select_scene.instantiate()
	UI.add_child(char_select_screen)
	char_select_screen.back_to_main.connect(back_to_main)
	
func show_tutorial():
	main_menu.queue_free()
	tutorial_screen = tutorial_scene.instantiate()
	UI.add_child(tutorial_screen)
	tutorial_screen.back_to_main.connect(back_to_main)

func back_to_main():
	if tutorial_screen:
		tutorial_screen.queue_free()
		tutorial_screen = null
	if char_select_screen:
		char_select_screen.queue_free()
		char_select_screen = null
	instantiate_main_menu()

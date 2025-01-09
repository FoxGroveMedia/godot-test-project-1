class_name TitleScene extends Node2D

const START_LEVEL : String = "res://levels/area_01/01.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream

@onready var new_game_button: Button = $CanvasLayer/Control/VBoxContainer/NewGame
@onready var continue_button: Button = $CanvasLayer/Control/VBoxContainer/Continue
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED
	
	if SaveManager.get_save_file() == null:
		continue_button.disabled = true
		continue_button.focus_mode = Control.FOCUS_NONE

	setup_title_screen()
	LevelManager.level_load_started.connect( exit_title_screen )
	pass


func setup_title_screen() -> void:
	AudioManager.play_music( music )
	new_game_button.pressed.connect( start_game )
	continue_button.pressed.connect( load_game )
	new_game_button.grab_focus()
	
	new_game_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	continue_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	
	pass


func start_game() -> void:
	play_audio( button_press_audio )
	LevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	pass


func exit_title_screen() -> void:
	PlayerManager.player.visible = true
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	
	self.queue_free()
	pass


func load_game() -> void:
	play_audio( button_press_audio )
	SaveManager.load_game()
	pass


func play_audio( _a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()

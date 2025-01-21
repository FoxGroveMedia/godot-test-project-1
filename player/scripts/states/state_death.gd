class_name State_Death extends State

@export var exhaust_audio : AudioStream
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"


# Lets start this party!
func init() -> void:
	pass


# What happens when the player enters this state?
func enter() -> void:
	player.animation_player.play( "death" )
	audio.stream = exhaust_audio
	audio.play()
	PlayerHud.show_game_over_screen()
	AudioManager.play_music( null )
	pass


# What happens when the player exits this state?
func exit() -> void:
	pass


# What happens during the _process update in this state?
func process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return null


# What happens durning the _physics_process update in this state?
func physics( _delta : float ) -> State:
	return null


# What happens with input events in this state?
func hanle_input( _event : InputEvent ) -> State:
	return null

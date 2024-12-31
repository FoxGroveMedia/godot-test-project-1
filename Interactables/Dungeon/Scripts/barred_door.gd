class_name BarredDoor extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var is_open_data: PersistentDataHandler = $PersistentDataHandler

# You keep on knockin', but you can't come in.
var is_open : bool = false # https://www.youtube.com/watch?v=Ul4GJkerx6U


# Lets start this party!
func _ready() -> void:
	is_open_data.data_loaded.connect( set_state )
	set_state()
	pass


# Knock knock
func open_door() -> void:
	animation_player.play("open_door")
	is_open_data.set_value()
	pass


# Close door
func close_door() -> void:
	animation_player.play("close_door")
	pass


# Set door state
func set_state() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play( "opened" )
	else:
		animation_player.play( "closed" )

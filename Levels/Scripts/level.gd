class_name Level extends Node2D


# Lets start this party!
func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect( _free_level )


# Unparent the player from the level
func _free_level() -> void:
	PlayerManager.unparent_player( self )
	queue_free()

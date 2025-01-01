extends Node

signal level_load_started
signal level_loaded
signal titlemap_bounds_changed( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset : Vector2


# Lets start this party!
func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()


# Get the player spawn position.
func get_player_spawn_position() -> Vector2:
	for child in get_parent().get_children():
		for grandchild in child.get_children():
			if grandchild.name == "PlayerSpawn":
				return grandchild.global_position
	return Vector2( 16, 16 )


# Change titlemap bounds
func change_titlemap_bounds( bounds : Array[ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	titlemap_bounds_changed.emit( bounds )


# Load new level
func load_new_level(
		level_path : String,
		_target_transition : String,
		_position_offset : Vector2,
		auto_save : bool = false
) -> void:
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file( level_path )
	
	await SceneTransition.fade_in()
	
	if auto_save == true:
		SaveManager.save_game()
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	
	pass

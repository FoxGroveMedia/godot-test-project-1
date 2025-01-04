extends Node

const SAVE_PATH = "user://Repository1-c.txt"

signal game_loaded
signal game_saved


# Current save dictionary.
var current_save : Dictionary = {
	gunter = "Congratulations! You've found the treasure! Don't mess with this code, or you might wind up in the Middle Ages, choose wisely!",
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0,
	},
	inventory = [],
	persistence = [],
	quests = []
}


# Lets start this party!
#func _ready() -> void:
	#pass


# Save the game.
func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_item_data()
	var file := FileAccess.open( SAVE_PATH, FileAccess.WRITE )
	var save_json = JSON.stringify( current_save )
	file.store_line( save_json )
	game_saved.emit()
	print("Game Saved!")
	pass


# Load the saved game.
func load_game() -> void:
	if FileAccess.file_exists( SAVE_PATH ):
		print("Loading game...")
		var file := FileAccess.open( SAVE_PATH, FileAccess.READ )
		var json := JSON.new()
		json.parse( file.get_line() )
		var save_dict := json.get_data() as Dictionary
		current_save = save_dict
		
		LevelManager.load_new_level( current_save.scene_path, "", Vector2.ZERO )
		
		await LevelManager.level_load_started
		
		PlayerManager.set_player_position( Vector2(current_save.player.pos_x, current_save.player.pos_y ) )
		PlayerManager.set_health( current_save.player.hp, current_save.player.max_hp )
		PlayerManager.INVENTORY_DATA.parse_save_data( current_save.inventory )
		
		await LevelManager.level_loaded
		
		game_loaded.emit()
		print("Game Loaded!")
	else:
		LevelManager.load_new_level( "res://levels/area_01/01.tscn", "", Vector2.ZERO )
		await LevelManager.level_load_started
		await LevelManager.level_loaded
		PlayerManager.set_player_position( LevelManager.get_player_spawn_position() )
		
		game_loaded.emit()
		print("Game Loaded!")


# Update the player from the saved data.
func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y


# Update scene path.
func update_scene_path() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p


# Update item data.
func update_item_data() -> void:
	current_save.inventory = PlayerManager.INVENTORY_DATA.get_save_data()


# Add persistent value.
func add_persistent_value( value : String ) -> void:
	if check_persistent_value( value ) == false:
		current_save.persistence.append( value )
	pass


# Check persistent value.
func check_persistent_value( value : String ) -> bool:
	var p = current_save.persistence as Array
	return p.has( value )

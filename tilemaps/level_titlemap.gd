class_name LevelTitlemap extends TileMapLayer

@export var title_size : float = 32


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.change_titlemap_bounds( get_titlemap_bounds() )
	pass # Replace with function body.


func get_titlemap_bounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * title_size ) + position
	)
	bounds.append(
		Vector2( get_used_rect().end * title_size ) + position
	)
	return bounds

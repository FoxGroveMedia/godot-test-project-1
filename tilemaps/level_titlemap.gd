class_name LevelTitlemap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.change_titlemap_bounds( get_titlemap_bounds() )
	pass # Replace with function body.


func get_titlemap_bounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * rendering_quadrant_size )
	)
	bounds.append(
		Vector2( get_used_rect().end * rendering_quadrant_size )
	)
	return bounds

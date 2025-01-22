extends PointLight2D


func _ready() -> void:
	flicker()
	pass


func flicker() -> void:
	energy = randf() * 0.1 + 0.9
	scale = Vector2( 1, 1, ) * energy
	await get_tree().create_timer( 0.125 ).timeout
	flicker()
	pass

extends Node


func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	SaveManager.load_game()
	pass

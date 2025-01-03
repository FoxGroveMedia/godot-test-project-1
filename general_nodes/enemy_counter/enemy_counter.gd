class_name EnemyCounter extends Node2D

signal enemies_defated


# Lets start this party!
func _ready() -> void:
	child_exiting_tree.connect( _on_enemy_destroyed )
	pass


# On enemy destroyed, die mofo die!!!
func _on_enemy_destroyed( e : Node2D ) -> void:
	if e is Enemy:
		if enemy_count() <= 1:
			enemies_defated.emit()
	pass


# Legolas, what do your elf eyes see?
func enemy_count() -> int:
	var _count : int = 0
	for c in get_children():
		if c is Enemy:
			_count += 1
	return _count

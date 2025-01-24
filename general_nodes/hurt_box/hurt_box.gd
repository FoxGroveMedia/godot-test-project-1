class_name HurtBox extends Area2D

signal did_damage

@export var damage : int = 1


func _ready() -> void:
	area_entered.connect( _area_entered )
	pass


# On area entered
func _area_entered( a : Area2D ) -> void:
	if a is HitBox:
		did_damage.emit()
		a.take_damage( self )
	pass

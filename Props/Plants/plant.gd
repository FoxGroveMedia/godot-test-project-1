class_name plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.damaged.connect( _take_damage )
	pass # Replace with function body.


# Ahh... what's that sound!?!  I think it's a mandrake.
func _take_damage( _damage : HurtBox ) -> void:
	queue_free()
	pass

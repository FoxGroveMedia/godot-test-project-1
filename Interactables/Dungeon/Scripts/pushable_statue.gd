class_name PushableStatue extends RigidBody2D

@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var push_speed : float = 30.0

var push_direction : Vector2 = Vector2.ZERO : set = _set_push


# Physics process stuff.
func _physics_process( _delta: float) -> void:
	linear_velocity = push_direction * push_speed
	pass


# Ah, push it... push it real good.
func _set_push( value : Vector2 ) -> void:
	push_direction = value
	if push_direction == Vector2.ZERO:
		audio.stop()
	else:
		audio.play()
	pass

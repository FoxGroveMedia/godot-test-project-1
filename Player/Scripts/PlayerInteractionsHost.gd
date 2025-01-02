class_name PlayerInteractionsHost extends Node2D

@onready var player : Player = $".."
@onready var hurt_box : HurtBox = %AttackHurtBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.direction_changed.connect( _update_direction )
	pass # Replace with function body.


# Update direction.
func _update_direction( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.DOWN:
			#rotation_degrees = 0
			position.x = 0
			position.y = 10
		Vector2.UP:
			#rotation_degrees = 180
			position.x = 0
			position.y = -35
		Vector2.LEFT:
			#rotation_degrees = 90
			position.x = -18
			position.y = -17
		Vector2.RIGHT:
			#rotation_degrees = -90
			position.x = 18
			position.y = -17
		_:
			rotation_degrees = 0
	pass

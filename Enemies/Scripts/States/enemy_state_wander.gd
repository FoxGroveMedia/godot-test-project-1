class_name EnemyStateWander extends EnemyState

@export var anim_name : String = "walk"
@export var walk_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction : Vector2


# Called when the node enters the scene tree for the first time.
func init() -> void:
	pass # Replace with function body.


# What happens when the player enters this state?
func enter() -> void:
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand = randi_range( 0, 3 )
	_direction = enemy.DIR_4[ rand ]
	enemy.velocity = _direction * walk_speed
	enemy.set_direction( _direction )
	enemy.update_animation( anim_name )
	pass


# What happens when the player exits this state?
func exit() -> void:
	pass


# What happens during the _process update in this state?
func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer < 0:
		return next_state
	return null


# What happens durning the _physics_process update in this state?
func physics( _delta : float ) -> EnemyState:
	return null

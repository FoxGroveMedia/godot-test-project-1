class_name EnemyStateChase extends EnemyState

const PATHFINDER : PackedScene = preload("res://enemies/pathfinder.tscn")

@export var anim_name : String = "chase"
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.25

@export_category("AI")
@export var vision_area : VisionArea
@export var attack_area : HurtBox
@export var state_aggro_duration : float = 0.5
@export var next_state : EnemyState

var pathfinder : Pathfinder

var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false


# Lets start this party!
func init() -> void:
	if vision_area:
		vision_area.player_entered.connect( _on_player_enter )
		if vision_area.has_signal("_on_player_enter"):
			vision_area.player_exited.disconnect( _on_player_exit )
	pass


# What happens when the player enters this state?
func enter() -> void:
	pathfinder = PATHFINDER.instantiate() as Pathfinder
	enemy.add_child( pathfinder )

	_timer = state_aggro_duration

	enemy.update_animation( anim_name )
	if attack_area:
		attack_area.monitoring = true
	pass


# What happens when the player exits this state?
func exit() -> void:
	pathfinder.queue_free()
	if attack_area:
		attack_area.monitoring = false
	_can_see_player = false
	pass


# What happens during the _process update in this state?
func process( _delta : float ) -> EnemyState:
	if PlayerManager.player.hp <= 0:
		return next_state

	_direction = lerp( _direction, pathfinder.move_dir, turn_rate )
	enemy.velocity = _direction * chase_speed
	
	if enemy.set_direction( _direction ):
		enemy.update_animation( anim_name )

	if _can_see_player == false:
		_timer -= _delta
		if _timer < 0:
			return next_state
	else:
		_timer = state_aggro_duration
	return null


# What happens durning the _physics_process update in this state?
func physics( _delta : float ) -> EnemyState:
	return null


# On player enter
func _on_player_enter() -> void:
	_can_see_player = true
	if(
		state_machine.current_state is EnemyStateStun or
		state_machine.current_state is EnemyStateDestroy
	):
		return
	state_machine.change_state( self )
	pass


# On player exit
func _on_player_exit() -> void:
	_can_see_player = false
	pass

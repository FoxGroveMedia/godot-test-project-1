class_name EnemyState extends Node

var enemy : Enemy
var state_machine : EnemyStateMachine


# Lets start this party!
func init() -> void:
	pass # Replace with function body.


# What happens when the player enters this state?
func enter() -> void:
	pass


# What happens when the player exits this state?
func exit() -> void:
	pass


# What happens during the _process update in this state?
func process( _delta : float ) -> EnemyState:
	return null


# What happens durning the _physics_process update in this state?
func physics( _delta : float ) -> EnemyState:
	return null

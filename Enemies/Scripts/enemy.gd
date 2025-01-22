class_name Enemy extends CharacterBody2D

signal direction_changed( new_direction : Vector2 )
signal enemy_damaged( hurt_box : HurtBox )
signal enemy_destroyed( hurt_box : HurtBox )

const DIR_4 : Array = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine
@onready var health_bar : ProgressBar = $HealthBar

@export_range(1, 20, 1) var hp : int = 3
@export_range(1, 20, 1) var current_health : int = 3
@export var invulnerable : bool = false

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.initialize( self )
	player = PlayerManager.player
	health_bar.max_value = hp
	health_bar.value = current_health
	hit_box.damaged.connect( _take_damage )
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Physics process
func _physics_process(_delta: float):
	move_and_slide()


# Set direction
func set_direction( _new_direction : Vector2 ) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round( 
		( direction + cardinal_direction * 0.1 ).angle() 
		/ TAU * DIR_4.size()
	))
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit( new_dir )
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


# Update animation
func update_animation( state : String ) -> void:
	animation_player.play( state + "_" + _anim_direction() )
	pass


# Get animation direction
func _anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"


# Take damage, why won't you die!?!
func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	current_health -= hurt_box.damage
	PlayerManager.shake_camera()
	health_bar.value = current_health
	if current_health > 0:
		enemy_damaged.emit( hurt_box )
	else:
		enemy_destroyed.emit( hurt_box )

@tool
class_name ItemPickup extends CharacterBody2D

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var item_data : ItemData : set = _set_item_data


# Lets start this party!
func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect( _on_body_entered )


# Process da physics... if you want to be in da gang you have to be cool, like daddy!
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide( velocity * delta )
	if collision_info:
		velocity = velocity.bounce( collision_info.get_normal() )
	velocity -= velocity * delta * 4


# On body entered.
func _on_body_entered( b ) -> void:
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item( item_data ) == true:
				item_picked_up()
	pass


# Wahoo I'm rich now, nevermind it's just a rock.
func item_picked_up() -> void:
	area_2d.body_entered.disconnect( _on_body_entered )
	audio_stream_player_2d.play()
	visible = false
	await audio_stream_player_2d.finished
	queue_free()
	pass


# Set item data.
func _set_item_data( value : ItemData ) -> void:
	item_data = value
	_update_texture()
	pass


# Update texture.
func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass

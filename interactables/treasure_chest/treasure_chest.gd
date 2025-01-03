@tool
class_name TreasureChest extends Node2D

@onready var sprite: Sprite2D = $ItemSprite
@onready var label: Label = $ItemSprite/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D
@onready var is_open_data: PersistentDataHandler = $IsOpen

@export_category("Dev Settings")
@export var reset_on_exit : bool = false

@export_category("Item Drops")
@export var items : Array[ DropData ]

@export var quantity : int = 1 : set = _set_quantity

@export_category("Random Item Settings")
@export_range(0,10,1) var min_number_of_items : int = 0
@export_range(0,10,1) var max_number_of_items : int = 0
@export_range(0,10,1) var min_quantity_per_item : int = 0
@export_range(0,10,1) var max_quantity_per_item : int = 0

# You keep on knockin', but you can't come in.
var is_open : bool = false # https://www.youtube.com/watch?v=Ul4GJkerx6U
var item_data : ItemData : set = _set_item_data


# Lets start this party!
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )
	is_open_data.data_loaded.connect( set_chest_state )
	set_chest_state()
	pass


# Set chest state.
func set_chest_state() -> void:
	is_open = is_open_data.value
	if is_open:
		animation_player.play("opened")
	else:
		animation_player.play("closed")


# Dude you give it ago I can't open it.
func player_interact() -> void:
	if is_open == true:
		return
	is_open = true
	is_open_data.set_value()
	animation_player.play("open_chest")

	quantity = quantity if quantity else 1
	
	#if item_data:
		#PlayerManager.INVENTORY_DATA.add_item( item_data, quantity )
	#else:
		#if max_number_of_items > 0:
			#for item in ItemManager.get_random_items( min_number_of_items, max_number_of_items ):
				#if max_quantity_per_item > 0:
					#quantity = randi_range(min_quantity_per_item, max_quantity_per_item)
				#PlayerManager.INVENTORY_DATA.add_item( load( item.resource_path ), quantity )
		#else:
			#PlayerManager.INVENTORY_DATA.add_item( load( ItemManager.get_random_item().resource_path ), quantity )
	
	if items.size() == 0:
		return

	for i in items.size():
		if items[ i ] == null or items[ i ].item == null:
			continue
		var drop_count : int = items[ i ].get_drop_count()
		for j in drop_count:
			item_data = items[ i ].item
			print(item_data)
			PlayerManager.INVENTORY_DATA.add_item( items[ i ].item, quantity )
	
	_update_texture()
	_update_label()
	pass


# On area entered.
func _on_area_enter( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( player_interact )
	pass


# On area exit, so long, and thanks for all the fish.
func _on_area_exit( _a : Area2D ) -> void:
	if reset_on_exit:
		is_open = false
		is_open_data.set_value()
		animation_player.play("closed")
	PlayerManager.interact_pressed.disconnect( player_interact )
	pass


# Set item data, did we get anything good?
func _set_item_data( value : ItemData ) -> void:
	if value:
		item_data = value
	pass


# Set quantity.
func _set_quantity( value : int ) -> void:
	quantity = value
	pass


# Update texture.
func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture


# Update label.
func _update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str( quantity )

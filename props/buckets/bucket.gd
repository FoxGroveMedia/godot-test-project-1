@tool
extends Node2D

@export var is_full : bool = true : set = _set_frame

@onready var top_of_bucket: Sprite2D = $top

func _ready() -> void:
	# This is now redundant with the tool script update, but kept for runtime behavior
	_set_frame(is_full)

func _set_frame(value: bool) -> void:
	is_full = value
	update_frame()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		update_frame()

func update_frame() -> void:
	if top_of_bucket:
		if is_full:
			top_of_bucket.frame = 1
		else:
			top_of_bucket.frame = 0
	else:
		pass

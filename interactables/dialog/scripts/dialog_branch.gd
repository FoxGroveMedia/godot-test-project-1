@tool
@icon("res://gui/dialog_system/icons/answer_bubble.svg")
class_name DialogBranch extends DialogItem

@export var text : String = "Placeholder text" : set = _set_text

var dialog_items : Array[ DialogItem ]


func _ready() -> void:
	super()
	
	if Engine.is_editor_hint():
		return
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append( c )
	pass


func _set_editor_display() -> void:
	var _p = get_parent()
	if _p is DialogChoice:
		if _p.dialog_branches.size() < 2:
			return
		example_dialog.set_dialog_choice( _p as DialogChoice )
		pass
	pass


func _set_related_text() -> void:
	var _p = get_parent()
	var _g = _p.get_parent()
	var _t = _g.get_child( _p.get_index() -1 )
	
	if _t is DialogText:
		example_dialog.set_dialog_text( _t )
		example_dialog.content.visible_characters = -1
	pass


func _set_text( value : String ) -> void:
	text = value
	if Engine.is_editor_hint():
		if example_dialog != null:
			_set_editor_display()

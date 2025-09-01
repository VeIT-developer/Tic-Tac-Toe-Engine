class_name ButtonHoverEffect
extends Node

@onready var parent: Control = get_parent()

@export var hover_modulate: Color = Color(1.0, 1.0, 1.0, 0.8)

var _default_modulate: Color = Color(1.0, 1.0, 1.0, 1.0)

@export var default_modulate: Color:
	get:
		return _default_modulate
	set(value):
		_default_modulate = value
		if parent:
			parent.self_modulate = _default_modulate

func _ready():
	if not (parent is Control):
		push_error("ButtonHoverEffect requires a Control-based parent!")
		return

	parent.mouse_entered.connect(_on_mouse_entered)
	parent.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	
	parent.self_modulate = Color(hover_modulate)

func _on_mouse_exited():
	
	parent.self_modulate = Color(_default_modulate)

func _exit_tree():
	if parent:
		parent.mouse_entered.disconnect(_on_mouse_entered)
		parent.mouse_exited.disconnect(_on_mouse_exited)

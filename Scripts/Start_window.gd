extends Control

@onready var text_control: Control = $Text
#const MAIN_SCENE: PackedScene = preload("res://Scenes/main.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	text_control.modulate.a = 0
	for i in range(50):
		await get_tree().create_timer(0.05).timeout
		text_control.modulate.a += 0.02
	for i in range(50):
		await get_tree().create_timer(0.05).timeout
		modulate.a -= 0.02 
	queue_free()

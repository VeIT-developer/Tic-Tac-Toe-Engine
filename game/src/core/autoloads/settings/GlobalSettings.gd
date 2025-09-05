extends Node

# Изменение темы(светлая/темная)

@onready var main_panel_style = load("res://game/assets/themes/panels/main_panel_style_box_flat.tres")
@onready var buttons_panel_style = load("res://game/assets/themes/panels/buttons_panel_style_box_flat.tres")
@onready var buttons_normal_style = load("res://game/assets/themes/buttons/buttons_normal_style_box_flat.tres")
@onready var buttons_hover_style = load("res://game/assets/themes/buttons/buttons_hover_style_box_flat.tres")
@onready var buttons_pressed_style = load("res://game/assets/themes/buttons/buttons_pressed_style_box_flat.tres")

func _ready():
	change_theme_mode("bright")

enum THEME_MODES {
	BRIGHT,
	DARK
}

var current_theme_mode: THEME_MODES = THEME_MODES.BRIGHT

const main_panel_color_modes = {
	"bright": Color(0.49803921580315, 0.49803921580315, 0.49803921580315),
	"dark": Color(0.22352941334248, 0.22352941334248, 0.22352941334248)
}

const buttons_panel_color_modes = {
	"bright": Color(0.56470590829849, 0.56470590829849, 0.56470590829849),
	"dark": Color(0.24705882370472, 0.24705882370472, 0.24705882370472)
}

const buttons_color_modes = {
	"normal": {
		"bright": Color(0.36078432202339, 0.36078432202339, 0.36078432202339),
		"dark": Color(0.20784313976765, 0.20784313976765, 0.20784313976765)
	},
	"hover": {
		"bright": Color(0.41176471114159, 0.41176471114159, 0.41176471114159),
		"dark": Color(0.2392156869173, 0.2392156869173, 0.2392156869173)
	},
	"pressed": {
		"bright": Color(0.41176471114159, 0.41176471114159, 0.41176471114159),
		"dark": Color(0.2392156869173, 0.2392156869173, 0.2392156869173)
	}
}

func change_theme_mode(theme: String):
	
	if theme == "dark" or theme == "bright":
		print("Изменение темы")
	else:
		push_error("Неизвестная тема")
		return
	
	main_panel_style.set_bg_color(main_panel_color_modes[theme])
	buttons_panel_style.set_bg_color(buttons_panel_color_modes[theme])	
	buttons_normal_style.set_bg_color(buttons_color_modes["normal"][theme])
	buttons_hover_style.set_bg_color(buttons_color_modes["hover"][theme])
	buttons_pressed_style.set_bg_color(buttons_color_modes["pressed"][theme]) 
#var texts_color_modes = {
#
#}

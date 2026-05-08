extends Node

var enabled: bool = false

const YELLOW := Color.YELLOW
const BLACK := Color.BLACK
const WHITE := Color.WHITE

const BUTTON_NORMAL_FLAT = preload("uid://5f86q6ci7g3n")
const BUTTON_HOVER_FLAT = preload("uid://c5bx6mcurutjk")



func set_enabled(value: bool) -> void:
	enabled = value

	if get_tree().current_scene:
		apply_to_tree(get_tree().current_scene)

func apply_to_tree(root: Node) -> void:
	_apply_node(root)

	for child in root.get_children():
		apply_to_tree(child)


func _apply_node(node: Node) -> void:
	if not enabled:
		_remove_node(node)
		return
		
	if node.name == "ALTO_CONTRASTE":
		node.visible = true

	if node is Button:
		_apply_button(node)
	elif node is Label:
		_apply_label(node)


func _apply_label(label: Label) -> void:
	label.add_theme_color_override("font_color", YELLOW)

func _apply_button(button: Button) -> void:
	
	if button.flat:
		button.add_theme_color_override("font_color", YELLOW)
		button.add_theme_color_override("font_hover_color", YELLOW)
		button.add_theme_color_override("font_pressed_color", YELLOW)
	else:
		button.add_theme_color_override("font_color", BLACK)
		button.add_theme_color_override("font_hover_color", BLACK)
		button.add_theme_color_override("font_hover_pressed_color", BLACK)
		button.add_theme_color_override("font_pressed_color", BLACK)

		var normal_style := _make_stylebox(YELLOW, YELLOW, 4)
		var hover_style := _make_stylebox(YELLOW, WHITE, 4)
		var pressed_style := _make_stylebox(YELLOW, YELLOW, 4)

		button.add_theme_stylebox_override("normal", normal_style)
		button.add_theme_stylebox_override("hover", hover_style)
		button.add_theme_stylebox_override("pressed", pressed_style)

func _remove_node(node: Node) -> void:
	if node.name == "ALTO_CONTRASTE":
		node.visible = false
		
	if node is Button:
		node.remove_theme_color_override("font_color")
		node.remove_theme_color_override("font_hover_color")
		node.remove_theme_color_override("font_pressed_color")

		node.remove_theme_stylebox_override("normal")
		node.remove_theme_stylebox_override("hover")
		node.remove_theme_stylebox_override("pressed")
		node.remove_theme_stylebox_override("focus")
		
		node.add_theme_stylebox_override("normal", BUTTON_NORMAL_FLAT)
		node.add_theme_stylebox_override("hover", BUTTON_HOVER_FLAT)
		node.add_theme_stylebox_override("pressed", BUTTON_NORMAL_FLAT)
		node.add_theme_stylebox_override("focus", BUTTON_HOVER_FLAT)

	elif node is Label:
		node.remove_theme_color_override("font_color")

func _make_stylebox(bg_color: Color, border_color: Color, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(20)
	return style

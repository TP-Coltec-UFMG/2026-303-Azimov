extends Node2D
@onready var transition: AnimatedSprite2D = $Input_transition


func _ready() -> void:
	HighContrast.apply_to_tree(self)
	transition.visible = true
	transition.frame = 8
	transition.play_backwards("default")
	pass 

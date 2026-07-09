class_name BaseScene extends Node

var player: Player = null

@onready var entrance_markers: Node2D = $EntranceMarkers

func _ready() -> void:
	player = get_node_or_null("Player") as Player

	if scene_manager.player:
		if player:
			player.queue_free()

		player = scene_manager.player

		if player.get_parent():
			player.get_parent().remove_child(player)

		add_child(player)

	position_player()


func position_player() -> void:
	if player == null:
		return

	var last_scene = scene_manager.last_scene_name

	if last_scene.is_empty():
		last_scene = "any"

	# Primeiro tenta achar o Marker2D com o nome exato da última cena
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == last_scene:
			player.global_position = entrance.global_position
			return

	# Se não achou o nome específico, usa o "any"
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == "any":
			player.global_position = entrance.global_position
			return

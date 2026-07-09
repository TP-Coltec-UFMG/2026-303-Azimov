class_name Scene_Maneger
extends Node

var player: Player
var last_scene_name: String
var tipo_sala_atual: int

var scene_dir_path := "res://Scenes/"


func change_scene(player_body: Player, to_scene_name: String) -> void:
	var current_scene := get_tree().current_scene
	
	if current_scene != null:
		last_scene_name = current_scene.name
	
	player = player_body
	
	if player.get_parent() != null:
		player.get_parent().remove_child(player)
	
	var full_path := scene_dir_path + to_scene_name + ".tscn"
	get_tree().call_deferred("change_scene_to_file", full_path)

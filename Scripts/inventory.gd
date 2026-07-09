extends Node2D
class_name Inventory

@onready var slot_1: Panel = $GridContainer/Slot1
@onready var slot_2: Panel = $GridContainer/Slot2
@onready var slot_3: Panel = $GridContainer/Slot3
@onready var slot_4: Panel = $GridContainer/Slot4
@onready var slot_5: Panel = $GridContainer/Slot5

var slots_por_item: Dictionary = {}


func _ready() -> void:
	slots_por_item = {
		"lanterna": slot_1,
		"gun": slot_2,
		"cartao": slot_3,
		"laptop": slot_4,
		"faca": slot_5
	}


func add_item(item_id: String, item_scene: PackedScene = null) -> bool:
	if item_id == "conhecimento":
		get_parent().get_parent().put_conhecimento()
		return true

	var slot = slots_por_item[item_id]
	return slot.put_item_on_inventory(item_scene)


func get_item_on_inventary(item_id: String) -> bool:
	return get_item_control(item_id) != null


func get_item_control(item_id: String) -> Node2D:
	if not slots_por_item.has(item_id):
		return null

	var slot = slots_por_item[item_id]
	return slot.item

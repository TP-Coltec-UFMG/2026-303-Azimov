extends Panel

var item: Node2D = null


func put_item_on_inventory(item_scene: PackedScene) -> bool:
	if item != null:
		return false

	self_modulate.a = 1.0

	item = item_scene.instantiate()
	add_child(item)

	item.position = Vector2(9, 9)
	item.scale = Vector2(0.5, 0.5)

	_make_unshaded(item)
	_desativar_interacao_do_item(item)

	return true


func _put_item_on_inventary(item_scene: PackedScene) -> void:
	put_item_on_inventory(item_scene)


func _desativar_interacao_do_item(node: Node) -> void:
	var interactable = node.get_node_or_null("Interectable")

	if interactable != null:
		interactable.is_interactable = false

		if interactable is Area2D:
			interactable.monitoring = false
			interactable.monitorable = false

	var pickup_component = node.get_node_or_null("PickupComponent")

	if pickup_component != null:
		pickup_component.queue_free()


func _make_unshaded(node: Node) -> void:
	if node is CanvasItem:
		var mat := CanvasItemMaterial.new()
		mat.light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED
		node.material = mat

	for child in node.get_children():
		_make_unshaded(child)

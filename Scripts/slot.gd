extends Panel

var item: Node2D = null


func put_item_on_inventory(item_scene: PackedScene) -> bool:
	var novo_item: Node2D = item_scene.instantiate()

	if item != null:
		var tipo_atual := _get_tipo(item)
		var tipo_novo := _get_tipo(novo_item)

		if tipo_novo <= tipo_atual:
			novo_item.queue_free()
			return false

		remove_child(item)
		item.queue_free()
		item = null

	self_modulate.a = 1.0

	item = novo_item
	add_child(item)

	item.position = Vector2(9, 9)

	_make_unshaded(item)
	_desativar_interacao_do_item(item)

	return true


func _put_item_on_inventary(item_scene: PackedScene) -> void:
	put_item_on_inventory(item_scene)


func _get_tipo(node: Node) -> int:
	var valor = node.get("tipo")

	if valor == null:
		return 0

	return int(valor)


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

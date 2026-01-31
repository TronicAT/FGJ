extends Control

@export var player: CharacterBody2D
var slot_nodes: Array

func _ready():
	slot_nodes = $HBoxContainer.get_children()

	if player != null and player.active_inventory != null:
		player.active_inventory.connect("item_changed", Callable(self, "_on_item_changed"))

	_update_ui()

func _on_item_changed(item):
	_update_ui()

func _update_ui():
	if player == null or player.active_inventory == null:
		return

	var inv = player.active_inventory

	for i in range(slot_nodes.size()):
		var slot = slot_nodes[i]

		if i < inv.slots.size():
			var item = inv.slots[i]

			if item.has("sprite") and item.sprite != null:
				slot.texture = item.sprite
			else:
				slot.texture = null

			slot.modulate = Color(1, 1, 1) if i == inv.current_index else Color(0.5, 0.5, 0.5)
		else:
			slot.texture = null
			slot.modulate = Color(0.5, 0.5, 0.5)

extends Node
class_name ActiveInventory

var slots: Array = []       # sisältää Item-olioita
var max_slots: int = 3
var current_index: int = 0

signal item_changed(item: Item)

func add_item(item: Item) -> bool:
	if item.type != Item.ItemType.ACTIVE:
		return false
	if slots.size() < max_slots:
		slots.append(item)
		emit_signal("item_changed", slots[current_index])
		return true
	return false

func switch_item(direction: int) -> void:
	if slots.size() == 0:
		return
	current_index = (current_index + direction) % slots.size()
	emit_signal("item_changed", slots[current_index])

func get_current_item() -> Item:
	if slots.size() == 0:
		return null
	return slots[current_index]

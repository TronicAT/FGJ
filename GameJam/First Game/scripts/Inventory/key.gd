extends Node
class_name Key

var items: Array = []

func add_item(item: Item) -> void:
	if item.type == Item.ItemType.PASSIVE and not has_item(item.name):
		items.append(item)

func has_item(item_name: String) -> bool:
	for item in items:
		if item.name == item_name:
			return true
	return false

# Item use and removal
func use_item(item_name: String) -> bool:
	for i in range(items.size()):
		if items[i].name == item_name:
			items.remove_at(i)
			return true  
	return false  

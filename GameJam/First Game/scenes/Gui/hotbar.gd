extends HBoxContainer

var items: Array = []
var slots: Array

func _ready():
	slots = get_children()
	for i in range(slots.size()):
		slots[i].pressed.connect(_on_slot_pressed.bind(i))
	update_hotbar()

# Lisää item HotBariin
func add_item(item: Item):
	if item.type == "key":
		return  # ÄLÄ lisää avainta hotbariin
	items.append(item)
	update_hotbar()

# Päivitä HotBar slotit
func update_hotbar():
	for i in range(slots.size()):
		if i < items.size():
			slots[i].update_to_slot(items[i])
		else:
			slots[i].update_to_slot(null)

# Slotin painallus
func _on_slot_pressed(index):
	var player = get_node("/root/Game/Player")
	var item = items[index]
	if item == player.active_item:
		player.deselect_item()
	else:
		player.select_item(item)
		

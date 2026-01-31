extends Button

@onready var icon_rect = $TextureRect

func _ready():
	focus_mode = Control.FOCUS_NONE

func update_to_slot(item: Item):
	if item == null:
		icon_rect.texture = null
		disabled = true
		return

	icon_rect.texture = item.icon
	disabled = false
	icon_rect.expand = true
	icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

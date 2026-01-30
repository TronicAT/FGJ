class_name Item
extends Resource

enum ItemType { PASSIVE, ACTIVE }

var name: String
var type: ItemType
var sprite: Texture2D
var attributes: Dictionary = {}

var jump_mask = Item.new()
jump_mask.name = "Jump Mask"
jump_mask.type = Item.ItemType.ACTIVE
jump_mask.attributes = {"jump_multiplier:" 2.0}

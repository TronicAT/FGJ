extends Resource
class_name Item

enum ItemType { PASSIVE, ACTIVE }

@export var name: String = ""
@export var type: ItemType = ItemType.PASSIVE
@export var sprite: Texture2D


#JumpMP
@export var jump_multiplier: float = 1.0

extends Resource
class_name Item

@export var name: String = "Item"
@export var icon: Texture2D

# mask, key, attack_mask
@export var type: String = "mask"

# Hyppymaskin ominaisuudet
@export var jump: float = 1.5

# Hyökkäysmaskin ominaisuudet
@export var hit: float = 1.0   # paljonko vahinkoa osuma tekee
@export var cooldown: float = 0.5  # jos joskus haluat rajoittaa osumatiheyttä

# Avaimen kohde (ei käytössä maskeille)
@export var target_object: NodePath


signal used(item, target)

func use(target = null):
	if type == "mask":
		print("Jump mask in use:", name, "multiplier:", jump)
		emit_signal("used", self, null)
	elif type == "key":
		if target != null and target.get_path() == target_object:
			print("Key used:", name, "target:", target.name)
			emit_signal("used", self, target)
		else:
			print("Cannot use this key here")

extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox

func _ready():
	# Peilaa alkuperäisestä suunnasta
	animated_sprite.scale.x = -1

	hitbox.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Pelaajan hyökkäyshitti osuu → vihollinen kuolee
	if body.name == "AttackHitbox":
		body.get_node_or_null("CollisionShape2D")
		return

	# Pelaajan keho osuu
	if body.name == "Player":
		var item = body.active_item

		# Pelaajalla on attack_mask → vihollinen kuolee, pelaaja EI kuole
		if item != null and item.type == "attack_mask":
			die()
		else:
			body.die()

func die():
	queue_free()

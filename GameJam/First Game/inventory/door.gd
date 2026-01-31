extends StaticBody2D

@onready var trigger = $Area2D

func _ready():
	trigger.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Varmista että törmääjä on pelaaja
	if not body is CharacterBody2D:
		return
	if not body.has_method("consume_key"):
		return

	# Jos pelaajalla on avaimia → avaa ovi
	if body.key_count > 0:
		body.key_count -= 1
		print("Door opened! Key consumed. Keys left:", body.key_count)
		call_deferred("queue_free")
	else:
		print("Door is locked! You need a key.")

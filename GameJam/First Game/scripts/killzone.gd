extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	# Killzone reagoi vain Playeriin
	if body.name != "Player":
		return

	# Jos pelaajalla on attack_mask → hän on kuolematon
	if body.active_item != null and body.active_item.type == "attack_mask":
		print("Player is immortal due to attack_mask")
		return

	# Muuten pelaaja kuolee
	print("You died!")

	# Poista pelaajan collision shape (valinnainen)
	var col = body.get_node_or_null("CollisionShape2D")
	if col:
		col.queue_free()

	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

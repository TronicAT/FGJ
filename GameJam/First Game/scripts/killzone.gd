extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	# Killzone reagoi vain Playeriin
	if body.name != "Player":
		return

	print("You died!")
	Engine.time_scale = 0.5

	# Poista pelaajan collision shape turvallisesti
	var col = body.get_node_or_null("CollisionShape2D")
	if col:
		col.queue_free()

	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

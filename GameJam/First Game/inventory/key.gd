extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Varmista että törmääjä on pelaaja
	if body.name != "Player":
		return

	# Lisää avain
	body.key_count += 1
	print("Picked up a key. Keys:", body.key_count)

	# Poista avain maailmasta
	queue_free()

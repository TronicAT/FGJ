extends Area2D

@export var item_resource: Item

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body):
	print("Collision detected with:", body.name)
	if body is CharacterBody2D:
		body.collect_item(item_resource)
		queue_free()

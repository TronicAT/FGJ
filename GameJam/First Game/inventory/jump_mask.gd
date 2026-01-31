extends Area2D

@export var hotbar: Node  # vedä inspectorissa HotBar node tähän
@export var item_resource: Resource  # tähän vedä jump_mask.tres

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		hotbar.add_item(item_resource)  # lisää item hotbariin
		queue_free()                     # poistaa itemin maailmasta

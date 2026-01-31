extends Node2D

const SPEED = 60
var direction = 1
var health = 1   # vihollisen elämäpisteet

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox   # Area2D, jonka sisällä CollisionShape2D

func _ready():
	hitbox.body_entered.connect(_on_body_entered)

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta

func _on_body_entered(body):
	if body.name != "Player":
		return

	var item = body.active_item

	if item != null and item.type == "attack_mask":
		die()
		return

	body.die()


func die():
	queue_free()

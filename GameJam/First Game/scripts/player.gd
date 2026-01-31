extends CharacterBody2D



#small piece of inventory
var passive_inventory: Key
var active_inventory: ActiveInventory

func _ready():
	passive_inventory = Key.new()
	add_child(passive_inventory)

	active_inventory = ActiveInventory.new()
	add_child(active_inventory)
	active_inventory.connect("item_changed", Callable(self, "_on_item_changed"))
	
func _on_item_changed(item: Item) -> void:
	jump_multiplier = 1.0
	speed_multiplier = 1.0

	if item == null:
		return
	
	# Only active items
	if item.type != Item.ItemType.ACTIVE:
		return

	# Apply multipliers
	jump_multiplier = item.jump_multiplier
	speed_multiplier = item.speed_multiplier


# === MOVEMENT ===
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# === STATS ===
var jump_multiplier := 1.0
var speed_multiplier := 1.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_just_pressed("mask_next"):
		active_inventory.switch_item(1)

	if Input.is_action_just_pressed("mask_prev"):
		active_inventory.switch_item(-1)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * jump_multiplier

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplier)

	move_and_slide()

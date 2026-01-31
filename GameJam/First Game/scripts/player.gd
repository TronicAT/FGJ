extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

<<<<<<< HEAD
# === READY ===
func _ready():
	passive_inventory = null
	
	active_inventory = ActiveInventory.new()
	add_child(active_inventory)
	active_inventory.connect("item_changed", Callable(self, "_on_item_changed"))

# === ITEM SIGNAL HANDLER ===
func _on_item_changed(item: Item) -> void:
	jump_multiplier = 1

	if item == null:
		return
	if item.type != Item.ItemType.ACTIVE:
		return

	jump_multiplier = item.jump_multiplier

# === ITEM COLLECTION ===
func collect_item(item: Item):
	if item == null:
		print("No item!")
		return

	print("Collected item:", item.name, "type:", item.type)

	if item.type == Item.ItemType.ACTIVE:
		if active_inventory.add_item(item):
			print("Mask added:", item.name)
		else:
			print("Mask inventory full!")
	elif item.type == Item.ItemType.PASSIVE:
		passive_inventory = item
		print("Key collected!")

# === PHYSICS PROCESS ===
=======
>>>>>>> 448c70db85872ca46f8646a695138812071f62ee
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

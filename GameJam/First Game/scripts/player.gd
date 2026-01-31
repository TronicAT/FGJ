extends CharacterBody2D

# === INVENTORY ===
var passive_inventory: Item           # esim. avain
var active_inventory: ActiveInventory # max 3 maskia

# === STATS ===
var jump_multiplier := 1.0
var speed_multiplier := 1.0

# === MOVEMENT CONSTANTS ===
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

# === READY ===
func _ready():
	passive_inventory = null
	
	active_inventory = ActiveInventory.new()
	add_child(active_inventory)
	active_inventory.connect("item_changed", Callable(self, "_on_item_changed"))

# === ITEM SIGNAL HANDLER ===
func _on_item_changed(item: Item) -> void:
	jump_multiplier = 1.0

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
func _physics_process(delta):
	# Vaihda maskia inputilla
	if Input.is_action_just_pressed("mask_next"):
		active_inventory.switch_item(1)
	if Input.is_action_just_pressed("mask_prev"):
		active_inventory.switch_item(-1)

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * jump_multiplier

	# Vaakasuuntainen liike
	var direction = Input.get_axis("move_left", "move_right")

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animoinnit
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Liike
	if direction != 0:
		velocity.x = direction * SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplier)

	move_and_slide()

# === DIE / RESPAWN ===
func die():
	print("Player died! Respawning...")
	velocity = Vector2.ZERO               # Nollaa nopeus

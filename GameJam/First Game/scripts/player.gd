extends CharacterBody2D

const SPEED = 130.0
var base_jump_velocity = 250.0
var jump_velocity = base_jump_velocity
var jump_multiplier = 1.0

var active_item: Item = null
var hotbar_items: Array = []  # vain maskit ja attack_maskit
var key_count: int = 0        # avaimet erikseen


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_hitbox = $AttackHitbox

var idle_anim = "idle"
var run_anim = "run"
var jump_anim = "jump"


func _ready():
	# Poista vanhat key-itemit hotbarista
	for i in range(hotbar_items.size() - 1, -1, -1):
		if hotbar_items[i].type == "key":
			hotbar_items.remove_at(i)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity

	var direction = Input.get_axis("move_left", "move_right")
	animated_sprite.flip_h = direction < 0

	var anim_name = ""
	if is_on_floor():
		anim_name = idle_anim if direction == 0 else run_anim
	else:
		anim_name = jump_anim

	if active_item != null and active_item.type == "mask":
		match anim_name:
			"idle": anim_name = "JumpMaskIdle"
			"run": anim_name = "JumpMaskRun"
			"jump": anim_name = "JumpMaskJump"

	if active_item != null and active_item.type == "attack_mask":
		match anim_name:
			"idle": anim_name = "AttackMaskIdle"
			"run": anim_name = "AttackMaskRun"
			"jump": anim_name = "AttackMaskJump"

	animated_sprite.play(anim_name)

	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)
	move_and_slide()


# --- Item select/deselect ---
func select_item(item: Item):
	if active_item != null:
		deselect_item()

	active_item = item

	match item.type:
		"attack_mask":
			attack_hitbox.monitoring = true
			attack_hitbox.visible = true

		"mask":
			jump_multiplier = item.jump
			jump_velocity = base_jump_velocity * jump_multiplier

		"key":
			key_count += 1
			print("Picked up a key. Keys:", key_count)


func deselect_item():
	if active_item != null:
		match active_item.type:
			"mask":
				jump_multiplier = 1.0
				jump_velocity = base_jump_velocity

			"attack_mask":
				attack_hitbox.monitoring = false
				attack_hitbox.visible = false

		active_item = null


# --- Avaimen kulutus ---
func consume_key() -> bool:
	if key_count > 0:
		key_count -= 1
		print("Key consumed. Keys left:", key_count)
		return true
	return false


func die():
	if active_item != null and active_item.type == "attack_mask":
		return

	active_item = null
	var col = get_node_or_null("CollisionShape2D")
	if col:
		col.call_deferred("queue_free")

	print("Player died")
	get_tree().reload_current_scene()

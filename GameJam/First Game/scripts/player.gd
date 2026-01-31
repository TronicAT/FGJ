extends CharacterBody2D



const SPEED = 130.0
var base_jump_velocity = 300.0
var jump_velocity = base_jump_velocity
var jump_multiplier = 1.0

var active_item: Item = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

# Base animaatiot (normaali asu)
var idle_anim = "idle"
var run_anim = "run"
var jump_anim = "jump"

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity

	# Liike
	var direction = Input.get_axis("move_left", "move_right")
	animated_sprite.flip_h = direction < 0

	# Päivitä animaatio
	var anim_name = ""
	if is_on_floor():
		anim_name = idle_anim if direction == 0 else run_anim
	else:
		anim_name = jump_anim

	# Jos maski käytössä → käytä maskin animaatioita
	if active_item != null and active_item.type == "mask":
		match anim_name:
			"idle":
				anim_name = "JumpMaskIdle"
			"run":
				anim_name = "JumpMaskRun"
			"jump":
				anim_name = "JumpMaskJump"
				
	if active_item != null and active_item.type == "attack_mask":
		match anim_name:
			"idle":
				anim_name = "AttackMaskIdle"
			"run":
				anim_name = "AttackMaskRun"
			"jump":
				anim_name = "AttackMaskJump"

	animated_sprite.play(anim_name)

	# Liike x
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)
	move_and_slide()

@onready var attack_hitbox = $AttackHitbox
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

func deselect_item():
	if active_item != null:
		match active_item.type:
			"mask":
				jump_multiplier = 1.0
				jump_velocity = base_jump_velocity

			"attack_mask":
				attack_hitbox.monitoring = false
				attack_hitbox.visible = false

			"key":
				pass

		print("Item deselected:", active_item.name)
		active_item = null
		
func die():
	# Pelaaja on kuolematon attack_maskin aikana
	if active_item != null and active_item.type == "attack_mask":
		return  # älä tee mitään

	# normaali kuoleminen
	print("Player died")
	get_tree().reload_current_scene()

extends KinematicBody2D

export var velocity = Vector2.ZERO
#helps the movement to be faster than the frames
export var MAX_SPEED = 100
#adds boost when moving for a long time
export var ACCELARATION = 200
#slide on stop
export var FRICTION = 50

enum{
	MOVE,
	ATTACK
}
var state = MOVE
var roll_vector =  Vector2.ZERO
var stats = PlayerStats

const DeathEffect = preload("res://Effects/CharacterDead.tscn")

onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")
onready var swordhitbox = $SwordHitBox/HitBox
onready var hurtbox = $Hurtbox

func _ready():
	stats.connect("no_health", self, "_on_PlayerStats_no_health")
	animationtree.active = true
	swordhitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		swordhitbox.knockback_vector = input_vector
		animationtree.set("parameters/Idle/blend_position", input_vector)
		animationtree.set("parameters/Run/blend_position", input_vector)
		animationtree.set("parameters/Attack/blend_position", input_vector)
		animationstate.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("Attack"):
		state=ATTACK

func attack_state(_delta):
	velocity = Vector2.ZERO
	animationstate.travel("Attack")
	
func attack_animation_done():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invinc(0.5)
	hurtbox.create_hit_effect()
	
func _on_PlayerStats_no_health():
	queue_free()
	var playerDeath = DeathEffect.instance()
	get_parent().add_child(playerDeath)
	playerDeath.global_position = global_position

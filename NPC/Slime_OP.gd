extends KinematicBody2D

const DeathEffect = preload("res://Effects/SlimeDeath.tscn")

var knockback = Vector2.ZERO

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var hurtbox = $Hurtbox
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback") 
onready var hitbox = $HitBox
onready var softCollision = $SoftCollision
export var TARGET_DISTANCE = 20

enum {
	IDLE,
	CHASE,
	ATTACK,
	DAMAGE
}

var velocity = Vector2.ZERO
var state = CHASE

func _ready():
	randomize() 
	animationtree.active = true
	hitbox.damage = stats.damage
	state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, stats.Friction*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, stats.Friction*delta)
			seek_player()
			animationstate.travel('Idle')
		CHASE:
			animationstate.travel('Run')
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				update_direction(direction, delta)
			else:
				state = IDLE
		ATTACK:
			animationstate.travel("Attack")
		DAMAGE:
			animationstate.travel("Damage")
			
	if (softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * delta * 200
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 125
	hurtbox.create_hit_effect()
	hurtbox.start_invinc(0.6)

func state_Done():
	var player = playerDetection.player
	if player != null:
		state = CHASE
	else:
		state = IDLE
	
func _on_Stats_no_health():
	queue_free()
	var slimeDeath = DeathEffect.instance()
	get_parent().add_child(slimeDeath)
	slimeDeath.global_position = global_position

func _on_EnemyAttackAnimate_body_entered(_body):
	state = ATTACK

func update_direction(position, delta):
	animationtree.set("parameters/Run/blend_position", position)
	animationtree.set("parameters/Idle/blend_position", position)
	animationtree.set("parameters/Attack/blend_position", position)
	animationtree.set("parameters/Damage/blend_position", position)
	velocity = velocity.move_toward(position * stats.Speed, stats.Acceleration * delta)

func _on_Hurtbox_invin_started():
	state = DAMAGE

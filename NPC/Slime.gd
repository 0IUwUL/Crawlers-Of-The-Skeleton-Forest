extends KinematicBody2D

const DeathEffect = preload("res://Effects/SlimeDeath.tscn")

var knockback = Vector2.ZERO

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback") 

enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = CHASE

func _ready():
	animationtree.active = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, stats.Friction*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, stats.Friction*delta)
			seek_player()
			animationstate.travel('Idle')
		WANDER:
			pass
		CHASE:
			animationstate.travel('Run')
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				animationtree.set("parameters/Run/blend_position", direction)
				animationtree.set("parameters/Idle/blend_position", direction)
				animationtree.set("parameters/Attack/blend_position", direction)
				animationtree.set("parameters/Damage/blend_position", direction)
				velocity = velocity.move_toward(direction * stats.Speed, stats.Acceleration * delta)
			else:
				state = IDLE
		ATTACK:
			animationstate.travel("Attack")
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE
	
func _on_Hurtbox_area_entered(area):
	animationstate.travel("Damage")
	stats.health -= area.damage
	knockback = area.knockback_vector * 125
	hurtbox.create_hit_effect()

func attack_Done():
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

func _on_EnemyAttackAnimate_body_entered(body):
	state = ATTACK

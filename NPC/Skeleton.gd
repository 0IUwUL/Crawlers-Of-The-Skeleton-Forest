extends KinematicBody2D

var knockback = Vector2.ZERO

const DeathEffect = preload("res://Effects/SkeletonDeath.tscn")

onready var stats = $Stats
onready var playerDetection = $PlayerDetection
onready var hurtbox = $Hurtbox
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback") 
onready var hitbox = $Position2D/HitBox
onready var softCollision = $SoftCollision
onready var wanderController = $WandererNode
export var TARGET_DISTANCE = 15

enum {
	IDLE,
	WANDER,
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
	state = pick_rand_new_state([IDLE, WANDER])
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, stats.Acceleration*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, stats.Velocity*delta)
			seek_player()
			animationstate.travel("Idle")
			if wanderController.get_time_left() == 0:
				update_state()
		WANDER:
			animationstate.travel('Run')
			seek_player()
			if wanderController.get_time_left() == 0:
				update_state()
			var AIdirection = global_position.direction_to(wanderController.target_position)
			update_direction(AIdirection, delta)
			
			if global_position.distance_to(wanderController.target_position) <= TARGET_DISTANCE:
				update_state()
		CHASE:
			animationstate.travel('Run')
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				update_direction(direction, delta)
			else:
				state = IDLE
		ATTACK:
			velocity = Vector2.ZERO
			animationstate.travel("Attack")
		DAMAGE:
			animationstate.travel("Damage")
			
	if (softCollision.is_colliding()):
		velocity += softCollision.get_push_vector() * delta * 200
		
	velocity = move_and_slide(velocity)
		
func seek_player():
	if playerDetection.can_see_player():
		state = CHASE


func update_direction(position, delta):
	animationtree.set("parameters/Run/blend_position", position)
	animationtree.set("parameters/Idle/blend_position", position)
	animationtree.set("parameters/Attack/blend_position", position)
	animationtree.set("parameters/Damage/blend_position", position)
	velocity = velocity.move_toward(position * stats.Speed, stats.Acceleration * delta)

func update_state():
	state = pick_rand_new_state([IDLE, WANDER])
	wanderController.reset_timer((rand_range(1,3)))
	
func pick_rand_new_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func attack_Done():
	var player = playerDetection.player
	if player != null:
		state = CHASE
	else:
		state = IDLE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 50
	hurtbox.create_hit_effect()
	hurtbox.start_invinc(0.5)
	
func _on_Stats_no_health():
	queue_free()
	var skeletonDeath = DeathEffect.instance()
	get_parent().add_child(skeletonDeath)
	skeletonDeath.global_position = global_position

func _on_EnemyAttackAnimate_body_entered(_body):
	state = ATTACK

func _on_Hurtbox_invin_started():
	if state != ATTACK:
		state = DAMAGE

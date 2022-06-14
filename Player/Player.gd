extends KinematicBody2D

var velocity = Vector2.ZERO
#helps the movement to be faster than the frames
const MAX_SPEED = 100
#adds boost when moving for a long time
const ACCELARATION = 200
#slide on stop
const FRICTION = 50

enum{
	MOVE,
	ATTACK
}
var state = MOVE

onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")

func _onready():
	animationtree.active = true

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

func attack_state(delta):
	animationstate.travel("Attack")

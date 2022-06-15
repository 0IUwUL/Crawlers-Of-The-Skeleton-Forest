extends KinematicBody2D

var velocity = Vector2.ZERO
#helps the movement to be faster than the frames
const MAX_SPEED = 50
#adds boost when moving for a long time
const ACCELARATION = 30
#slide on stop
const FRICTION = 5

onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")


func _ready():
	animationtree.active = true
	

#
#func _physics_process(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
#
#	if input_vector != Vector2.ZERO:
#		animationtree.set("parameters/Idle/blend_position", input_vector)
#		animationtree.set("parameters/Run/blend_position", input_vector)
#		animationstate.travel("Run")
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
#	else:
#		animationstate.travel("Idle")
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
##	
#	velocity = move_and_slide(velocity)


func _on_Hurtbox_area_entered(area):
	queue_free()
	

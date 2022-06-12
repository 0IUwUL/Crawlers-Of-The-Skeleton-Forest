extends KinematicBody2D

var velocity = Vector2.ZERO
#helps the movement to be faster than the frames
const MAX_SPEED = 100
#adds boost when moving for a long time
const ACCELARATION = 200
#slide on stop
const FRICTION = 50

#var animationplayer = null

#shortcut in godot so no need for _ready func
onready var animationplayer = $AnimationPlayer

#func _ready():
	#animationplayer = $AnimationPlayer



func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationplayer.play("Run_Right")
		elif input_vector.x < 0:
			animationplayer.play("Run_Left")
		else:
			animationplayer.play("Run_Right")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELARATION * delta)
	else:
		animationplayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#	
	velocity = move_and_slide(velocity)

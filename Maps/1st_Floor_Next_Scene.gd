extends Area2D
#
export(String, FILE, "*.tscn") var path_to_scene

onready var cond = FloorCond
onready var collision = $CollisionShape2D
onready var animation = $AnimatedSprite
onready var transition = $Transition_Screen

func _ready():
	cond.enemies = 12
	cond.connect("no_enemies", self, "_on_Status_No_Enemies")
	collision.set_deferred("disabled", true)
	transition._load()
	
func change_scene():
	transition.transition()

func _on_MapAdvance_body_entered(_body):
	change_scene()
	
func _on_Status_No_Enemies():
	print("off")
	collision.set_deferred("disabled", false)
	animation.visible = true
	animation.play("Portal")
	
func _on_Transition_Screen_transition():
	if ResourceLoader.exists(path_to_scene):
		var _error = get_tree().change_scene(path_to_scene)

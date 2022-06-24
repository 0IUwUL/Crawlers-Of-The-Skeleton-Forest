extends Area2D
#
export(String, FILE, "*.tscn") var path_to_scene

onready var cond = FloorCond
onready var collision = $CollisionShape2D

func _ready():
	cond.enemies = 12
	cond.connect("no_enemies", self, "_on_Status_No_Enemies")
	collision.set_deferred("disabled", true)

func change_scene():
	if ResourceLoader.exists(path_to_scene):
		var _error = get_tree().change_scene(path_to_scene)

func _on_MapAdvance_body_entered(_body):
	change_scene()
	
func _on_Status_No_Enemies():
	print("off")
	collision.set_deferred("disabled", false)
	

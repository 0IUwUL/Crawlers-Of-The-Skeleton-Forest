extends CanvasLayer

onready var play = $AnimationPlayer
var stats = PlayerStats
var interact
onready var color = $ColorRect
onready var label = $Label
export(String, FILE, "*.tscn") var path_to_scene

func _ready():
	stats.connect("no_health", self, "_on_PlayerStats_no_health")
	interact = false
	color.visible = false
	label.visible = false

func _on_PlayerStats_no_health():
	color.visible = true
	label.visible = true
	play.play("You_Died")
	interact = true
	
func _input(_event):
	if interact:
		if Input.is_action_just_pressed("ui_accept"):
			var _load = get_tree().change_scene(path_to_scene)
			stats.health = 13

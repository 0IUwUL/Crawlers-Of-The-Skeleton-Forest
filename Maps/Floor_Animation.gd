extends Node2D

onready var transition = $Transition_Screen
func _ready():
	transition._load()


func _on_Transition_Screen_transition():
	pass # Replace with function body.

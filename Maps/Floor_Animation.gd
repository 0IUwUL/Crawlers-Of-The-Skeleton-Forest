extends Node2D

onready var transition = $Transition_Screen
func _ready():
	transition._load()

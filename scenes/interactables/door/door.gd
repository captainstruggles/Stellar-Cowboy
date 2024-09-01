extends Area2D

signal Opened()
signal Closed()

@onready var APlayer : AnimationPlayer = get_node("Sprite2D/AnimationPlayer")



# Called when the node enters the scene tree for the first time.
func _ready():
	APlayer.play("Close")

func _on_body_entered(body):
	if body is CharacterBody2D:
		emit_signal("Opened")
		APlayer.play("Open")

func _on_body_exited(body):
	if body is CharacterBody2D:
		emit_signal("Closed")
		APlayer.play("Close")

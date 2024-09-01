extends Area2D

@export var scene : String
@export var spot : String 

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.RegisterTransporter(self)

func _on_body_entered(body):
	if body is CharacterBody2D && body.get_name() == "Player":
		print("Entered Teleporter")
		SceneManager.LoadNewScene(spot, scene)

func _on_body_exited(body):
	if body is CharacterBody2D && body.get_name() == "Player":
		print("Left Teleporter")
		SceneManager.ResetTransport(self)

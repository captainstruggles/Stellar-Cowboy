extends Area2D

@export var scene : PackedScene
@export var spot : String 

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.RegisterTransporter(self)

func _on_body_entered(body):
	if body is CharacterBody2D && body.get_name() == "Player":
		SceneManager.LoadNewScene(spot, scene)


func _on_body_exited(body):
	if body is CharacterBody2D && body.get_name() == "Player":
		SceneManager.ResetTransport(true)

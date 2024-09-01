extends Control

var player = preload("res://scenes/player/player.tscn")

func _ready():
	SceneManager.currentScene = self

func _on_new_game_pressed():
	var newPlayer = player.instantiate()
	get_tree().root.add_child(newPlayer)
	#SceneManager.currentSpot = "Apartment"
	SceneManager.LoadNewScene("Apartment", "Apartment")

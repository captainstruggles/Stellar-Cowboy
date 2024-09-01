extends Control

var newGame = preload("res://scenes/locations/apartment/apartment.tscn")
var player = preload("res://scenes/player/player.tscn")

func _ready():
	SceneManager.currentScene = self

func _on_new_game_pressed():
	SceneManager.LoadNewScene("Apartment", newGame)
	var newPlayer = player.instantiate()
	get_tree().root.add_child(newPlayer)
	queue_free()

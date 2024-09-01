extends Node

var SceneMap = {
	"Apartment" : "res://scenes/locations/apartment/apartment.tscn",
	"LowerVale" : "res://scenes/locations/LowerVale/lowervale.tscn"
	}
	
var MainUI = "res://scenes/UI/hud/hud.tscn"
var IsMainMenuLoaded = false
var currentScene
var currentSpot : String
var transporters : Array[Area2D]
var resetTransport = true

signal LoadedNewScene(location : Area2D)
func LoadNewScene(spot : String, scene : String):
	if !IsMainMenuLoaded:
		var packedMenu = load(MainUI) as PackedScene
		var newMenu = packedMenu.instantiate()
		add_child(newMenu)
		IsMainMenuLoaded = true
	if resetTransport:
		currentScene.queue_free()
		ClearTransporters()
		currentSpot = spot
		var packedScene = load(SceneMap[scene]) as PackedScene
		var newScene = packedScene.instantiate()
		add_child(newScene)
		currentScene = newScene
		resetTransport = false

func RegisterTransporter(transporter : Area2D):
	transporters.append(transporter)
	if transporter.spot == currentSpot:
		LoadedNewScene.emit(transporter)
	
func ClearTransporters():
	transporters = []
	
func ResetTransport(transporter : Area2D):
	if FindTransporter(transporter) != null:
		resetTransport = true

func FindTransporter(trans : Area2D) -> Area2D:
	for transporter in transporters:
		if transporter == trans:
			return transporter
	return null


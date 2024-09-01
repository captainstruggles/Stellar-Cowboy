extends Node

var currentScene
var currentSpot : String
var transporters : Array[Area2D]
var resetTransport = true

signal LoadedNewScene(location : Area2D)
func LoadNewScene(spot : String, packScene : PackedScene):
	currentScene.queue_free()
	ClearTransporters()
	var newScene = packScene.instantiate()
	add_child(newScene)
	currentScene = newScene
	resetTransport = false

func RegisterTransporter(transporter : Area2D):
	transporters.append(transporter)
	if transporter.spot == currentSpot:
		LoadedNewScene.emit(transporter)
	
func ClearTransporters():
	transporters = []
	
func ResetTransport(reset : bool):
	resetTransport = reset

##NOT USING
func FindTransporterSpot(spot : String) -> Area2D:
	for transporter in transporters:
		if transporter.spot == spot:
			return transporter
	return null


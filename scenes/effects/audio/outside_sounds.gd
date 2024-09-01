extends Node2D

@export var VolumeDimAmount : float = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.connect("EnteredBuilding", _dimAudio)
	EventManager.connect("LeftBuilding", _unDimAudio)

func _dimAudio():
	for child in get_children():
		if child is AudioStreamPlayer2D:
			child.volume_db -= VolumeDimAmount

func _unDimAudio():
	for child in get_children():
		if child is AudioStreamPlayer2D:
			child.volume_db += VolumeDimAmount

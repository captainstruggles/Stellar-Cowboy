extends TileMap

## Node that contains interior items such as light to hide when not inside building
@export var Interior : Node2D
## Node that contains exerior items such as light to hide when inside the building
@export var Exterior : Node2D
## Sound Played when entering building
@export var Interior_Audio : AudioStreamPlayer2D

@onready var EnteredBuildingDetector : Area2D = get_node("Exterior/Area2D")
@onready var FadeOutBuildingDetector : Area2D = get_node("FadeOut/Area2D")

var _exterior_layer : int = 0
var _fade_layer : int = 2
var exterior_hide_color : Color = Color(1.0, 1.0, 1.0, 0)
var exterior_show_color : Color = Color(1.0, 1.0, 1.0, 1)
var exterior_fade_color : Color = Color(1.0, 1.0, 1.0, .3)

# Called when the node enters the scene tree for the first time.
func _ready():
	if EnteredBuildingDetector:
		EnteredBuildingDetector.connect("body_entered", _enter_building)
		EnteredBuildingDetector.connect("body_exited", _exit_building)
	if FadeOutBuildingDetector:
		FadeOutBuildingDetector.connect("body_entered", _fade_out_building)
		FadeOutBuildingDetector.connect("body_exited", _fade_in_building)
	if Interior:
		Interior.visible = false
	if Exterior:
		Exterior.visible = true

func _enter_building(body):
	if body is CharacterBody2D && body.name == "Player":
		set_layer_modulate(_exterior_layer, exterior_hide_color)
		set_layer_modulate(_fade_layer, exterior_hide_color)
		EventManager.EmitEnteredBuilding()
		if Interior:
			Interior.visible = true
			if Interior_Audio:
				Interior_Audio.play_Audio()
		if Exterior:
			Exterior.visible = false

func _exit_building(body):
	if body is CharacterBody2D && body.name == "Player":
		set_layer_modulate(_exterior_layer, exterior_show_color)
		set_layer_modulate(_fade_layer, exterior_show_color)
		EventManager.EmitLeftBuilding()
		if Interior:
			Interior.visible = false
			if Interior_Audio:
				Interior_Audio.stop()
		if Exterior:
			Exterior.visible = true

func _fade_out_building(body):
	if body is CharacterBody2D && body.name == "Player":
		set_layer_modulate(_fade_layer, exterior_fade_color)

func _fade_in_building(body):
	if body is CharacterBody2D && body.name == "Player":
		set_layer_modulate(_fade_layer, exterior_show_color)

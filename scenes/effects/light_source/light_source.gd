extends PointLight2D

## Dim light to alternative color over time
@export var Dimmer : bool
## Time range of dimming the light
@export var DimmerTime : float = 10
## The default color of the light source 
@export var DimmerColor : Color
## Light source will turn off at random intervals
@export var Flicker : bool
## Max flicker timer length if Flicker enabled
@export var FlickerTime : float = 10

@onready var flicker_timer : Timer = get_node("Flicker")
@onready var dimmer_timer : Timer = get_node("Dimmer")

var dimming_to_original = false
var original_color : Color
var rng = RandomNumberGenerator.new()
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	if Dimmer:
		dimmer_timer.wait_time = DimmerTime
		original_color = color
		tween = get_tree().create_tween()
		tween.tween_property(self, "color", DimmerColor, DimmerTime)
		dimmer_timer.start()
	if Flicker:
		_reset_flicker_Timer()

func _reset_flicker_Timer():
	var time = .1
	if visible:
		time = rng.randf_range(0, FlickerTime)
	flicker_timer.wait_time = time
	flicker_timer.start()

func _on_flicker_timeout():
	visible = !visible
	_reset_flicker_Timer()

func _on_dimmer_timeout():
	tween.kill()
	tween = get_tree().create_tween()
	if !dimming_to_original:
		tween.tween_property(self, "color", original_color, DimmerTime)
	else:
		tween.tween_property(self, "color", DimmerColor, DimmerTime)
	
	dimming_to_original = !dimming_to_original

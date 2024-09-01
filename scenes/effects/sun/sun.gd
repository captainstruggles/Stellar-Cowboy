extends DirectionalLight2D

## Number of seconds it takes to loop a full 24 hours
@export var FullDayCycle : float = 24

@onready var _timer : Timer = get_node("Timer")

var _isDay : bool = true
var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	var timerCycle = FullDayCycle / 2
	tween = get_tree().create_tween()
	tween.tween_property(self, "energy", 0, timerCycle)
	_isDay = true
	_timer.wait_time = timerCycle
	_timer.start()

func _on_timer_timeout():
	var timerCycle = FullDayCycle / 2
	tween.kill()
	tween = get_tree().create_tween()
	var newEnergy = 1
	_isDay = !_isDay
	if _isDay:
		newEnergy = 0
	tween.tween_property(self, "energy", newEnergy, timerCycle)

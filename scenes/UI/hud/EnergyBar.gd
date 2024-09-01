extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("EnergyUpdated", _update)
	max_value = PlayerData.HungerLevelMax
	value = PlayerData.HungerLevelCurrent

func _update(amount : float):
	value = amount

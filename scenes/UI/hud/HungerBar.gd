extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("HungerUpdated", _update)
	max_value = PlayerData.EnergyLevelMax
	value = PlayerData.EnergyLevelCurrent

func _update(amount : float):
	value = amount

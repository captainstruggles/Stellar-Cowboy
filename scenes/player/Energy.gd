extends Timer

func _on_timeout():
	PlayerData.EnergyUpdate(-PlayerData.EnergyRate)

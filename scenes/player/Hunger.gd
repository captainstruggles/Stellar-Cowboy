extends Timer

func _on_timeout():
	PlayerData.HungerUpdate(-PlayerData.HungerRate)

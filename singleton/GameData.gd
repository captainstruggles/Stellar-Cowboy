extends Node

var SpawnLocations : Array[Node2D] = []
var DropOffLocations : Array[StaticBody2D] = []

func AddSpawnLocation(spawner : Node2D):
	SpawnLocations.append(spawner)

func RemoveSpawnLocation(spawner : Node2D):
	var x = 0
	for item in SpawnLocations:
		if item == spawner:
			SpawnLocations.remove_at(x)
			return
		else:
			x += 1

func AddDroppOffLocation(dropOff : StaticBody2D):
	DropOffLocations.append(dropOff)

func RemoveDroppOffLocation(dropOff : StaticBody2D):
	var x = 0
	for item in SpawnLocations:
		if item == dropOff:
			DropOffLocations.remove_at(x)
			return
		else:
			x += 1

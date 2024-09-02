extends Node2D

var package = preload("res://scenes/interactables/package/package.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for gig in GigManager.GigLog:
		if gig.Scene == SceneManager.CurrentSceneName && !gig.IsObjectiveAchieved:
			if gig.GigType == GigManager.GigTypes.PACKAGE_PICKUP:
				var newPackage = package.instantiate()
				add_child(newPackage)
				newPackage.setGig(gig)
	#GameData.AddSpawnLocation(self)

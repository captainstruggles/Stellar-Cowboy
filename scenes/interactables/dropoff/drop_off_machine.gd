extends StaticBody2D

var currentGigs : Array[Gig]

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.AddDroppOffLocation(self)

func interact():
	for currentGig in currentGigs:
		if currentGig && PlayerData.Inventory.has(currentGig.Location):
			PlayerData.InventoryRemove(currentGig.Location)
			GigManager.GigComplete(currentGig)
			Utils.removeItemFromArray(currentGigs, currentGig)

func setGig(newGig : Gig):
	currentGigs.append(newGig)

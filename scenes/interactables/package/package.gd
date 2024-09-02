extends StaticBody2D

var currentGig : Gig

func interact():
	if currentGig:
		if PlayerData.InventoryAdd(self):
			currentGig.IsObjectiveAchieved = true
			get_parent().remove_child(self)

func setGig(newGig : Gig):
	currentGig = newGig

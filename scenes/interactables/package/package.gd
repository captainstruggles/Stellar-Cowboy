extends StaticBody2D

var currentGig : Gig

func interact():
	if currentGig:
		if PlayerData.InventoryAdd(self):
			get_parent().remove_child(self)

func setGig(newGig : Gig):
	currentGig = newGig

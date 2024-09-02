extends VBoxContainer

@onready var Name : Label = get_node("Name")
@onready var Description : Label = get_node("Description")

func setGigData(gig : Gig):
	Name.text = gig.Name
	Description.text = gig.Description

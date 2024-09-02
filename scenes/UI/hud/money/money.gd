extends Control

@onready var label = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "$" + str(PlayerData.Credits)
	PlayerData.connect("CreditsUpdated", updateCredits)

func updateCredits(credits : int):
	label.text = "$" + str(credits)

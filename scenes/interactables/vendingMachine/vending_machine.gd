extends StaticBody2D

enum VendingTypes { 
	Food,
	Medical,
	Energy
}

## Service this machine will dispense
@export var VendingType : VendingTypes

@onready var light_source : PointLight2D = get_node("light_source")

# Called when the node enters the scene tree for the first time.
func _ready():
	if VendingType == VendingTypes.Food:
		light_source.color = Color("Green")
	if VendingType == VendingTypes.Medical:
		light_source.color = Color("Red")
	if VendingType == VendingTypes.Energy:
		light_source.color = Color("Blue")

func interact():
	if VendingType == VendingTypes.Food:
		PlayerData.HungerUpdate(25)
	if VendingType == VendingTypes.Medical:
		PlayerData.HealthUpdate(25)
	if VendingType == VendingTypes.Energy:
		PlayerData.EnergyUpdate(25)

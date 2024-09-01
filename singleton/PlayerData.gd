extends Node

var HungerLevelMax : float = 100
var HungerLevelCurrent : float = 100
var HungerRate : float = 1
signal HungerUpdated(amount : float)

var EnergyLevelMax : float = 100
var EnergyLevelCurrent : float = 100
var EnergyRate : float = 1
signal EnergyUpdated(amount : float)

var HealthLevelMax : float = 100
var HealthLevelCurrent : float = 100
var HealthRate : float = 1
signal HealthUpdated(amount : float)

var Inventory : Array[Node]
var MaxInventorySize : int = 1

var Credits : int = 0

func _ready():
	GigManager.connect("GigCompleted", _gigReward)
	
func _gigReward(gig : Gig):
	Credits += gig.Reward

func HungerUpdate(amount : float):
	HungerLevelCurrent += amount
	if HungerLevelCurrent > HungerLevelMax:
		HungerLevelCurrent = HungerLevelMax
	HungerUpdated.emit(HungerLevelCurrent)

func EnergyUpdate(amount : float):
	EnergyLevelCurrent += amount
	if EnergyLevelCurrent > EnergyLevelMax:
		EnergyLevelCurrent = EnergyLevelMax
	EnergyUpdated.emit(EnergyLevelCurrent)

func HealthUpdate(amount : float):
	HealthLevelCurrent += amount
	if HealthLevelCurrent > HealthLevelMax:
		HealthLevelCurrent = HealthLevelMax
	HealthUpdated.emit(HealthLevelCurrent)

func InventoryAdd(item : Node) -> bool:
	if Inventory.size() >= MaxInventorySize:
		return false
	else:
		Inventory.append(item)
		return true

func InventoryRemove(requestedItem: Node):
	var x = 0
	for item in Inventory:
		if item == requestedItem:
			Inventory.remove_at(x)
			return
		else:
			x += 1

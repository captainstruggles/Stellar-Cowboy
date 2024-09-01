extends Node

var GigLog : Array[Gig]
var gigFileLoc : String = "res://data/gigs.json"
var GigData = {}
var rng = RandomNumberGenerator.new()

var packagePrefab : PackedScene = load("res://scenes/interactables/package/package.tscn")

enum GigTypes {
	PACKAGE_PICKUP
}

signal GigLogUpdate(gigLog : Array[Gig])
signal GigCompleted(gig : Gig)

func GigComplete(gig : Gig):
	if GigLog.has(gig):
		GigLog = Utils.removeItemFromArray(GigLog, gig)
		GigCompleted.emit(gig)

func generateRandomGig(npc : CharacterBody2D) -> Gig:
	var gigKey = rng.randi_range(0, GigTypes.size() - 1)
	var newGig : Gig
	if gigKey == GigTypes.PACKAGE_PICKUP:
		newGig = createPackageGig(npc)
	
	AddNewGig(newGig)
	return newGig

func AddNewGig(gig):
	GigLog.append(gig)
	GigLogUpdate.emit(GigLog)

func createPackageGig(npc : CharacterBody2D) -> Gig:
	#Create package
	var newPackage = packagePrefab.instantiate()
	var randomSpawnLoc = rng.randi_range(0, GameData.SpawnLocations.size() - 1)
	#var location = GameData.SpawnLocations[randomSpawnLoc].position
	GameData.SpawnLocations[randomSpawnLoc].add_child(newPackage)
	#newPackage.position = location
	#Find Destination
	var randomDropOffLoc = rng.randi_range(0, GameData.DropOffLocations.size() - 1)
	var dropOff = GameData.DropOffLocations[randomDropOffLoc]
	var name = "Get Package"
	var reward = 100
	var newGig = Gig.new(name, newPackage, dropOff, reward, npc)
	newPackage.setGig(newGig)
	dropOff.setGig(newGig)
	return newGig
	

extends Node

var GigLog : Array[Gig]
var PackageGigFileLoc : String = "res://data/PackageGigs.json"
var PackageGigData
var GigData = {}
var rng = RandomNumberGenerator.new()

var packagePrefab : PackedScene = load("res://scenes/interactables/package/package.tscn")

enum GigTypes {
	PACKAGE_PICKUP
}

enum GigDifficulties {
	Easy,
	Medium,
	Hard,
	VeryHard,
	Impossible,
	SuicideRun
}

signal GigLogUpdate(gigLog : Array[Gig])
signal GigCreated(gig : Gig)
signal GigCompleted(gig : Gig)

func _ready():
	var rawPackageGigs = Utils.ReadFile(PackageGigFileLoc)
	PackageGigData = JSON.parse_string(rawPackageGigs)

func GigComplete(gig : Gig):
	if GigLog.has(gig):
		GigLog = Utils.removeItemFromArray(GigLog, gig)
		GigCompleted.emit(gig)
		GigLogUpdate.emit(GigLog)

func generateRandomGig(npc : String, difficulty : GigDifficulties, gigTypes : Array[GigTypes]) -> Gig:
	var gigKey = rng.randi_range(0, gigTypes.size() - 1)
	var newGig : Gig
	if gigKey == GigTypes.PACKAGE_PICKUP:
		newGig = createPackageGig(npc, difficulty)
	AddNewGig(newGig)
	return newGig

func AddNewGig(gig):
	GigLog.append(gig)
	GigCreated.emit(gig)
	GigLogUpdate.emit(GigLog)
	
func spawnQuestItem(gig : Gig):
	if gig.GigType == GigTypes.PACKAGE_PICKUP:
		var newPackage = packagePrefab.instantiate()
		var randomSpawnLoc = rng.randi_range(0, GameData.SpawnLocations.size() - 1)
		GameData.SpawnLocations[randomSpawnLoc].add_child(newPackage)

func createPackageGig(npc : String, difficulty : GigDifficulties) -> Gig:
	#Create package
	var diffLevel = GigDifficulties.find_key(difficulty)
	var gigKey = rng.randi_range(0, PackageGigData[diffLevel].size() - 1)
	var newGigData = PackageGigData[diffLevel][gigKey]
	#Find Destination
	var name = newGigData["Name"]
	var reward = newGigData["Reward"]
	var scene = newGigData["Scene"]
	var description = newGigData["Description"]
	var newGig = Gig.new(name, description, scene, GigTypes.PACKAGE_PICKUP, reward, npc)
	return newGig
	
func GetGigByNPC(npcName : String) -> Gig:
	for gig in GigLog:
		if gig.NPC == npcName:
			return gig
	return null
	

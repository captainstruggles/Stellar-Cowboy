extends Control

var GigEntry : PackedScene = preload("res://scenes/UI/hud/quest_tracker/gig_entry.tscn")

@onready var GigLogs : VBoxContainer = get_node("VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	GigManager.connect("GigLogUpdate", rebuildLogs)
	destroyLogs()

func destroyLogs():
	for child in GigLogs.get_children():
		child.queue_free()

func createLogs(gigs : Array[Gig]):
	for gig in gigs:
		var newEntry = GigEntry.instantiate()
		GigLogs.add_child(newEntry)
		newEntry.setGigData(gig)
		

func rebuildLogs(gigs : Array[Gig]):
	destroyLogs()
	createLogs(gigs)
	

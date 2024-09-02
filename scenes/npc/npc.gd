extends CharacterBody2D

#@onready var ChatText : RichTextLabel = get_node("ChatText")
#@onready var ChatDismissTimer : Timer = get_node("ChatText/DismissTimer")
@onready var NameLabel = get_node("NameLabel")

## Name of NPC
@export var NPCName: String = "Default"
## This NPC will give out random task for player to make money
@export var IsGigGiver : bool = false
## This NPC will give out hard code quest for story progress
@export var GigDifficulty : GigManager.GigDifficulties = GigManager.GigDifficulties.Easy
@export var GigTypes : Array[GigManager.GigTypes] = [GigManager.GigTypes.PACKAGE_PICKUP]

const SPEED = 100.0
const hiddenName = "?????"
var dialogue : Dialogue
var currentGig : Gig

func _ready():
	if NpcManager.IsAContact(NPCName):
		NameLabel.set_label(NPCName)
	else:
		NameLabel.set_label(hiddenName)
	
	currentGig = GigManager.GetGigByNPC(NPCName)
	
	#GigManager.connect("GigCompleted", gigCompleted)
	dialogue = DialogManager.GetDialogueForPlayer(NPCName)
	

func interact():
	if DialogManager.currentNPCTalking == null:
		if !NpcManager.IsAContact(NPCName):
			DialogManager.start_dialog(self, global_position, dialogue.Intro)
			NameLabel.set_label(NPCName)
			NpcManager.AddToContacts(NPCName)
		elif IsGigGiver && !currentGig:
			DialogManager.start_dialog(self, global_position, dialogue.GigStart)
			currentGig = GigManager.generateRandomGig(NPCName, GigDifficulty, GigTypes)
		elif currentGig && !currentGig.IsObjectiveAchieved:
			DialogManager.start_dialog(self, global_position, dialogue.GigWaiting)
		elif currentGig && currentGig.IsObjectiveAchieved:
			DialogManager.start_dialog(self, global_position, dialogue.GigFinished)
			currentGig = null
			GigManager.GigComplete(currentGig)
		else:
			DialogManager.start_dialog(self, global_position, dialogue.Default)
	elif DialogManager.currentNPCTalking == self:
		DialogManager.continue_dialog()
	

#func gigCompleted(gig : Gig):
#	if gig.NPC == NPCName:
#		hasCompletedGig = true

func leftRange():
	print("Left Range")
	if DialogManager.currentNPCTalking == self:
		DialogManager.end_dialog()

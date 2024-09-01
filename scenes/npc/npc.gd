extends CharacterBody2D

@onready var ChatText : RichTextLabel = get_node("ChatText")
@onready var ChatDismissTimer : Timer = get_node("ChatText/DismissTimer")
@onready var NameLabel = get_node("NameLabel")

## Name of NPC
@export var NPCName: String = "Default"
## This NPC will give out random task for player to make money
@export var isGigGiver : bool = false
## This NPC will give out hard code quest for story progress
@export var isStoryGiver : bool = false

const SPEED = 100.0
const hiddenName = "?????"
var hasplayerMet = false
var hasGivenGig = false
var hasCompletedGig = false
var dialogue : Dialogue

func _ready():
	NameLabel.set_label(hiddenName)
	GigManager.connect("GigCompleted", gigCompleted)
	dialogue = DialogManager.GetDialogueForPlayer(NPCName)
	

func interact():
	if DialogManager.currentNPCTalking == null:
		if !hasplayerMet:
			DialogManager.start_dialog(self, global_position, dialogue.Intro)
			hasplayerMet = true
			NameLabel.set_label(NPCName)
		elif isGigGiver && !hasGivenGig:
			DialogManager.start_dialog(self, global_position, dialogue.GigStart)
			GigManager.generateRandomGig(self)
			hasGivenGig = true
		elif hasGivenGig && !hasCompletedGig:
			DialogManager.start_dialog(self, global_position, dialogue.GigWaiting)
		elif hasCompletedGig:
			DialogManager.start_dialog(self, global_position, dialogue.GigFinished)
			hasGivenGig = false
			hasCompletedGig = false
		else:
			DialogManager.start_dialog(self, global_position, dialogue.Default)
	elif DialogManager.currentNPCTalking == self:
		DialogManager.continue_dialog()

func gigCompleted(gig : Gig):
	if gig.NPC == self:
		hasCompletedGig = true

func leftRange():
	print("Left Range")
	if DialogManager.currentNPCTalking == self:
		DialogManager.end_dialog()

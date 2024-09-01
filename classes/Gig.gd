class_name Gig

var NPC : CharacterBody2D
var Name : String
var Location : Node
var Destination : Node
var Reward : int

func _init(_name: String, _location : Node, _destination : Node, _reward : int, _npc : CharacterBody2D):
	Name = _name
	Location = _location
	Destination = _destination
	Reward = _reward
	NPC = _npc

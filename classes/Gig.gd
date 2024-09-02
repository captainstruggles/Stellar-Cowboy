class_name Gig

var NPC : String
var Name : String
var Scene : String
var Reward : int
var GigType : GigManager.GigTypes
var Description : String
var IsObjectiveAchieved : bool = false

func _init(_name: String, _description : String, _scene : String, _gigType : GigManager.GigTypes, _reward : int, _npc : String):
	Name = _name
	Scene = _scene
	GigType = _gigType
	Reward = _reward
	NPC = _npc
	Description = _description

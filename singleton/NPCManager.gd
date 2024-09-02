extends Node

var NPCContacts : Array[Contact]

func IsAContact(npcName : String) -> bool:
	for contact in NPCContacts:
		if contact.Name == npcName:
			return true
	return false

func AddToContacts(npcName : String):
	if !IsAContact(npcName):
		var newContact = Contact.new(npcName)
		NPCContacts.append(newContact)

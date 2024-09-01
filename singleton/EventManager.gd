extends Node

signal EnteredBuilding()
signal LeftBuilding()

func EmitEnteredBuilding():
	EnteredBuilding.emit()

func EmitLeftBuilding():
	LeftBuilding.emit()

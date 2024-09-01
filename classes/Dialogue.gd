class_name Dialogue

var Intro : Array[String]
var GigStart : Array[String]
var GigWaiting : Array[String]
var GigFinished : Array[String]
var Default : Array[String]

func _init(data):
	for line in data["Intro"]:
		Intro.append(line)
	for line in data["GigStart"]:
		GigStart.append(line)
	for line in data["GigWaiting"]:
		GigWaiting.append(line)
	for line in data["GigFinished"]:
		GigFinished.append(line)
	for line in data["Default"]:
		Default.append(line)

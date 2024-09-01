extends Node

## May Need to double check if this even works?
func has_property(object, name: String) -> bool:
	var my_script: Script = object.get_script() as Script
	return my_script.get_script_property_list().has(name) if my_script else false

func has_func(object, name: String) -> bool:
	var my_script: Script = object.get_script() as Script
	if my_script:
		var listOfMethods = my_script.get_script_method_list()
		for method in listOfMethods:
			if method.name == name:
				return true
	return false

## May Need to double check if this even works?
func has_constant(object, name: String) -> bool:
	var my_script: Script = object.get_script() as Script
	return my_script.get_script_constant_map().keys().has(name) if my_script else false
	
func ReadFile(fileLoc):
	var file = FileAccess.open(fileLoc, FileAccess.READ)
	var content = file.get_as_text()
	return content

func removeItemFromArray(arrayList : Array, item) -> Array:
	var x = 0
	for thing in arrayList:
		if thing == item:
			arrayList.remove_at(x)
			break;
		else:
			x += 1
	return arrayList

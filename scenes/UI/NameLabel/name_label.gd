extends MarginContainer

@onready var NameLabel : Label = get_node("Name")
var currentLabel : String = ""

const MAX_WIDTH = 256

func set_label(value : String):
	NameLabel.text = value
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		#label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #Wait for x
		await resized #Waot for y
		custom_minimum_size.y = size.y

extends Node

@onready var chat_bubble_scene = preload("res://scenes/interactables/chatBox/chatBox.tscn")

#Chat Data
var DialogueData = {}
var dialogeConfigFile = "res://data/dialogue.json"

#Chat Bubble Vars
var dialog_lines : Array[String] = []
var current_line_index = 0
var text_box
var text_box_position: Vector2
var is_dialog_active = false
var can_advance_line = false

var currentNPCTalking

func _ready():
	var rawData = Utils.ReadFile(dialogeConfigFile)
	DialogueData = JSON.parse_string(rawData)

func start_dialog(npc : CharacterBody2D, position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return
	
	currentNPCTalking = npc
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = chat_bubble_scene.instantiate()
	text_box.finished_text.connect(_on_text_box_finished)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished():
	can_advance_line = true

func continue_dialog():
	if is_dialog_active && can_advance_line:
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			end_dialog()
			return
		
		_show_text_box()

func end_dialog():
	text_box.queue_free()
	is_dialog_active = false
	currentNPCTalking = null
	current_line_index = 0
	
func GetDialogueForPlayer(name : String) -> Dialogue:
	return Dialogue.new(DialogueData[name])

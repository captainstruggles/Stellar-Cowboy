extends StaticBody2D

#@onready var light : PointLight2D = get_node("SpotLight")
@onready var AnimPlayer : AnimationPlayer = get_node("AnimationPlayer")

@export var IsTVOn : bool = false

func _ready():
	toggleTV()

func interact():
	IsTVOn = !IsTVOn
	toggleTV()

func toggleTV():
	if IsTVOn:
		AnimPlayer.play("On")
	else:
		AnimPlayer.play("Off")

func _on_animation_player_animation_finished(anim_name):
	toggleTV()

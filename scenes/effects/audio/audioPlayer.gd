extends AudioStreamPlayer2D

## Randomize the Pitch of the boolean to make the sound little more randomized
@export var RandomizePitch : bool
## Randomize the Base of the boolean to make the sound little more randomized
@export var RandomizeBase : bool
## Loop the audio forever
@export var Loop : bool
## Stop the audio at time specified
@export var AudioLength : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("finished", _finished)
	if Loop:
		play()

func play_Audio():
	if AudioLength:
		AudioLength.start()
		play()

func _on_audio_length_timeout():
	stop()

func _finished():
	if Loop:
		play()

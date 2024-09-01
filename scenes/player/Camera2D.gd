extends Camera2D

# Zoom minimum and maximum
var zoom_min = Vector2(.200001, .200001)
var zoom_max = Vector2(2, 2)

# Zoom speed
var zoom_speed = Vector2(.2, .2)

# Desired zoom
var des_zoom = zoom

func _process(delta):
	zoom = lerp(zoom, des_zoom, .2)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("zoom_in"):
			if des_zoom > zoom_min:
				des_zoom -= zoom_speed
		elif event.is_action_pressed("zoom_out"):
			if des_zoom < zoom_max:
				des_zoom += zoom_speed

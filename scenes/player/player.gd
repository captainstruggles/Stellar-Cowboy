extends CharacterBody2D


const SPEED = 100.0
@onready var APlayer : AnimationPlayer = get_node("AnimationPlayer")

var entitiesDetected = []
func _ready():
	SceneManager.connect("LoadedNewScene", movePlayerToSpot)
	
func movePlayerToSpot(spot : Area2D):
	self.position = spot.position

func _physics_process(delta):
	handleMovement()
	handleInteraction()
	
func handleInteraction():
	if Input.is_action_just_released("interact"):
		for entity in entitiesDetected:
			if Utils.has_func(entity, "interact"):
				entity.interact()

func handleMovement():
	var directionX = Input.get_axis("left", "right")
	var directionY = Input.get_axis("up", "down")
	var isWalking = false
	if directionX:
		velocity.x = directionX * SPEED
		isWalking = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
		isWalking = true
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if isWalking:
		APlayer.play("Walk")
	else:
		APlayer.play("Idle")
	move_and_slide()

func _on_detector_body_entered(body):
	if body != self:
		entitiesDetected.push_back(body)

func _on_detector_body_exited(body):
	if body != self:
		var x = 0
		for entity in entitiesDetected:
			if entity == body:
				var lostEntity = entitiesDetected.pop_at(x)
				if Utils.has_func(lostEntity, "leftRange"):
					lostEntity.leftRange()
				break
			else:
				x = x + 1

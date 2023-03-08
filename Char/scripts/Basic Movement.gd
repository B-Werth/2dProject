extends CharacterBody2D

@export var moveSpeed : float = 50
@export var startingPos : Vector2 = Vector2(0,1)

@onready var animationTree = $AnimationTree
@onready var stateMachine = animationTree.get("parameters/playback")


func  _ready():
	update_animation_parameters(startingPos)

func _physics_process(_delta):
	_inventarManager()

	var inputDir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	update_animation_parameters(inputDir)

	velocity = inputDir.normalized() * moveSpeed

	move_and_slide()

	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animationTree.set("parameters/Walk/blend_position", move_input)
		animationTree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		stateMachine.travel("Walk")
	else:
		stateMachine.travel("Idle")


func _inventarManager():
	if(Input.is_action_just_pressed("ui_cancel")):
		print_debug("Moinsen")

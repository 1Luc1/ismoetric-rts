extends CharacterBody2D

@onready var select_frame: Node2D = $Selection
@onready var agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	set_physics_process(false)
	agent.velocity_computed.connect(on_velocity_computed)
	agent.target_reached.connect(on_target_reached)
	input_event.connect(_on_character_body_2d_input_event)
	mouse_entered.connect(_on_soldier_mouse_entered)
	mouse_exited.connect(_on_soldier_mouse_exited)


func _physics_process(delta: float) -> void:
	var next_location = agent.get_next_path_position()
	get_tree().call_group("fog_handler", "blend_fog", next_location)
	var direction = (next_location - global_transform.origin).normalized()
	var v = velocity.move_toward(direction * 300, 540 * delta)
	agent.set_velocity(v)


func on_velocity_computed(safe_velocity: Vector2) -> void:
	set_direction(safe_velocity)


func set_target_location(target):
	set_physics_process(true)
	agent.set_target_position(target)


func on_target_reached() -> void:
	set_physics_process(false)


func set_direction(input_direction):	
	velocity = input_direction
	move_and_slide()


func _on_character_body_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("left_mouse_btn"):
			get_tree().call_group("input_handler", "units_clicked", [self])


func _exit_tree():
	get_tree().call_group("input_handler", "unselect")


func _on_soldier_mouse_entered():
	if not is_selected():
		MouseCursor.reset()
		MouseCursor.play_selection()


func _on_soldier_mouse_exited():
	if is_selected():
		MouseCursor.reset()
		MouseCursor.play_move()


func unselect():
	select_frame.visible = false


func select():
	select_frame.visible = true


func is_selected() -> bool:
	return select_frame.visible

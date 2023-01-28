extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var select_frame: Node2D = $Selection
@onready var agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	set_physics_process(false)
	agent.velocity_computed.connect(on_velocity_computed)
	agent.target_reached.connect(on_target_reached)
	input_event.connect(_on_character_body_2d_input_event)
	mouse_entered.connect(_on_mcv_mouse_entered)
	mouse_exited.connect(_on_mcv_mouse_exited)


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
	update_animation_parameters(input_direction.limit_length(1))
	velocity = input_direction
	move_and_slide()
	pick_new_state()


func update_animation_parameters(move_input: Vector2) -> void:
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Move/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)


func pick_new_state() -> void:
	if(velocity != Vector2.ZERO):
		state_machine.travel("Move")
	else:
		state_machine.travel("Idle")


func _on_character_body_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("left_mouse_btn"):
			get_tree().call_group("input_handler", "units_clicked", [self])
		if Input.is_action_just_pressed("right_mouse_btn") and MouseCursor.visible:
			deploy()


func deploy():
	var tilemap = get_parent()
	tilemap.build(global_position, 4)
	tilemap.remove_navigation(global_position, Vector2i(2,2))
	get_tree().call_group("input_handler", "unselect")
	MouseCursor.reset()
	queue_free()


func _exit_tree():
	get_tree().call_group("input_handler", "unselect")


func unselect():
	select_frame.visible = false


func select():
	select_frame.visible = true
	#MouseCursor.play_deploy()


func is_selected() -> bool:
	return select_frame.visible


func _on_mcv_mouse_entered():
	MouseCursor.reset()
	if is_selected():
		MouseCursor.play_deploy()
	else:
		MouseCursor.play_selection()


func _on_mcv_mouse_exited():
	if is_selected():
		MouseCursor.reset()
		MouseCursor.play_move()

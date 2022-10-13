extends Camera2D

var camera_margin = 30
var camera_speed = 800
var camera_movement = Vector2(0,0)

func _ready():
	drag_horizontal_enabled = false
	drag_vertical_enabled = false
	set_enable_follow_smoothing(true)
	set_follow_smoothing(4)
	#set_physics_process(false)

func _physics_process(delta):
	var rec = get_viewport().get_visible_rect()
	var v = get_viewport().get_mouse_position()
	if rec.size.x - v.x <= camera_margin:
		camera_movement.x += camera_speed * delta
	if v.x <= camera_margin:
		camera_movement.x -= camera_speed * delta
	if rec.size.y - v.y <= camera_margin:
		camera_movement.y += camera_speed * delta
	if v.y <= camera_margin:
		camera_movement.y -= camera_speed * delta
		
	position += camera_movement * get_zoom()
	
	# Set camera movement to zero, update old mouse position.
	camera_movement = Vector2(0,0)

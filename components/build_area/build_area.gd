extends Area2D

@onready var build_area_polygon: Polygon2D = $Polygon2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var parent: TileMap = get_parent()

var valid := false
var size: Vector2i
var base_size: int = 64
var valid_color := Color(0.55,1,1,0.42)
var invalid_color := Color(1,0.1,0.1, 0.8)

func _ready():
	assert(parent.is_class("TileMap"), "parent has to be tilemap")
	make_invisible()


func _physics_process(_delta):
	global_position = parent.getCellGlobalPosition(get_global_mouse_position())


func disable():
	make_invisible()
	make_invalid()
	global_position = Vector2(0,0)

#2x2
func enable(_size: Vector2i):
	size = _size
	make_visible()
	make_valid()
	var pol = PackedVector2Array([
		Vector2(0, base_size/2.0),
		Vector2(base_size*size.y, -((size.y-1)*(base_size/2.0))),#1x1 1x2 2x2
		#1x1 1x2 2x2
		# -32 -64 -96
		
		Vector2(abs(size.x-size.y)*base_size, -(((size.x-1)*(base_size/2.0))+(size.y*(base_size/2.0)))),
		#Vector2(abs(size.x-size.y)*base_size, -((size.x-1)*base_size)+(size.y*(base_size/2))),
		#Vector2(64, -(((size.x-1)*(base_size/2.0))+(size.x*(base_size/2.0)))),
		Vector2(-(base_size*size.x), -((size.x-1)*(base_size/2.0)))
		])
	build_area_polygon.set_polygon(pol)
	collision_polygon.set_polygon(pol)


func is_valid() -> bool:
	return valid


func _on_build_area_area_entered(area):
	if area.is_in_group("build_area"):
		make_invalid()


func _on_build_area_area_exited(area):
	if area.is_in_group("build_area"):
		make_valid()


func make_valid():
	build_area_polygon.color = valid_color
	valid = true
	
func make_invalid():
	build_area_polygon.color = invalid_color
	valid = false
	
func make_visible():
	visible = true
	set_physics_process(true)
	
func make_invisible():
	visible = false
	set_physics_process(false)

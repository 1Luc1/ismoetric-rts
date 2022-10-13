extends Node2D

var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO
var dragging = false

func _draw():
	if dragging:
		draw_rect(Rect2(drag_start, drag_end - drag_start), Color(1,1,1), false)
		
func update_status(start, _end, drag):
	drag_start = start
	drag_end = _end
	dragging = drag
	queue_redraw()
	
func end() -> Array[CharacterBody2D]:
	dragging = false
	queue_redraw()
	var select_rectangle := RectangleShape2D.new()

	select_rectangle.extents = ((drag_end - drag_start) / 2).abs()
	var space  = get_world_2d().direct_space_state
	var query := PhysicsShapeQueryParameters2D.new()
	query.shape = select_rectangle
	query.transform = Transform2D(0, (drag_end + drag_start)/2)
	var selected = space.intersect_shape(query)
	var units:Array[CharacterBody2D] = []
	for unit in selected:
		if unit.collider is CharacterBody2D:
			units.append(unit.collider)
	return units

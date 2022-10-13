class_name BuildButton
extends TextureButton

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var data: Dictionary
var build_time: float
var money_part: float


func init(building_data: Dictionary):
	texture_normal = load("res://components/gui/icons/" + building_data.icon)
	data = building_data


func _ready():
	gui_input.connect(handle_gui_input)
	timer.timeout.connect(timeout)
	progress_bar.value_changed.connect(progress_value_changed)
	build_time = data.cost / 40
	progress_bar.max_value = data.cost
	tooltip_text = "$ " + str(data.cost)
	money_part = data.cost / build_time / 10


func handle_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if progress_bar.value == data.cost:
					get_tree().call_group("input_handler", "icon_selected", {"tile_id": data.index, "size": data.size, "btn": self})
				else:
					data.queue.add(self)
			MOUSE_BUTTON_RIGHT:
				if timer.is_stopped():
					GameData.add_money(progress_bar.value)
					reset()
				else:
					timer.stop()
					label.text = "STOP"


func start_building():
	timer.start()


func reset_building():
	progress_bar.value = 0
	label.text = ""
	build_time = data.cost / 40


func progress_value_changed(new_value):
	if new_value >= data.cost:
		timer.stop()
		label.text = "FINISH"


func timeout():
	var moneyGet = GameData.get_money(money_part)
	if moneyGet != 0:
		build_time -= 0.1
		label.text = "%0.0f" % build_time
		progress_bar.value += moneyGet


func reset():
	data.queue.remove(self)


func set_queue_cnt(cnt):
	if cnt <= 0:
		$QueueCnt.text = ""
	else: 
		$QueueCnt.text = str(cnt)

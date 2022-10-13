extends CanvasLayer

@onready var building_container: GridContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer/BuildingContainer
@onready var unit_container: GridContainer = $Panel/MarginContainer/VBoxContainer/HBoxContainer/UnitContainer
@onready var queue := BuildingQueue.new()
@onready var panel: Panel = $Panel
@onready var power: ProgressBar = $Panel2/ProgressBar
var build_btn_res := preload("res://components/gui/build_button/BuildButton.tscn")

var building_ids: Array[int]
var unit_names: Array[String]

func _ready():
	add_to_group("gui")
	panel.mouse_entered.connect(mouse_entered)
	panel.mouse_exited.connect(mouse_exited)


func add_power(value):
	power.value += value


func remove_power(value):
	power.value -= value


func mouse_entered():
	MouseCursor.save_current()
	MouseCursor.reset()


func mouse_exited():
	MouseCursor.revert()


func _process(_delta):
	var money = GameData.global_money
	$Panel/MarginContainer/VBoxContainer/Label.text = "$ " + str(money)


func add_buildings(buildings: Array[Dictionary]):
	for building_data in buildings:
		if not building_ids.has(building_data.index):
			var btn = build_btn_res.instantiate()
			building_data.queue = queue
			btn.init(building_data)
			building_container.add_child(btn)
			building_ids.push_back(building_data.index)


func add_units(building: Building, units: Array[Dictionary]):
	for unit_data in units:
		if not unit_names.has(unit_data.icon):
			var btn := TextureButton.new()
			btn.texture_normal = load("res://components/gui/icons/" + unit_data.icon)
			unit_container.add_child(btn)
			btn.pressed.connect(building.spawn_unit.bind(unit_data))
			unit_names.push_back(unit_data.icon)


func remove_buildings(buildings: Array[Dictionary]):
	for building_data in buildings:
		print("remove_building: ", building_data)

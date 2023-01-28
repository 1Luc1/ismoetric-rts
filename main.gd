extends Node2D
# FOG SCRIPT ADD TO Main to work
# BAD PERFORMANCE WITH ALOT OF UNITS

const LightTexture = preload("res://assets/Light04.png")
const GRID_SIZE = 8

@onready var fog: Sprite2D = $Fog

#var display_width = ProjectSettings.get("display/window/size/viewport_width")
#var display_height = ProjectSettings.get("display/window/size/viewport_height")

#TODO get size of map and set fog
var display_width = 4500
var display_height = 4500

var fogImage = Image.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width()/2.0, LightTexture.get_height()/2.0)
var light_rect

func _ready():
	add_to_group("fog_handler")
	fog.centered = false
	var fog_image_width = int(float(display_width)/float(GRID_SIZE))
	var fog_image_height = int(float(display_height)/float(GRID_SIZE))
	fogImage = Image.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	lightImage.convert(Image.FORMAT_RGBAH)
	light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(), lightImage.get_height()))
	fog.scale *= GRID_SIZE
	# draw first time
	blend_fog(Vector2(584,296))


func blend_fog(at_position):
	fogImage.blend_rect(lightImage, light_rect, (at_position/GRID_SIZE)-light_offset)
	fog.texture = ImageTexture.create_from_image(fogImage)

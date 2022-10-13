extends Control

enum Animations {
	Default, Deploy, Selection, Move
}

@onready var deploy: Sprite2D = $Node2d/deploy
@onready var selection: Sprite2D = $Node2d/selection
@onready var move: Sprite2D = $Node2d/move
@onready var anim: AnimationPlayer = $Node2d/AnimationPlayer

var current_animation: Animations = Animations.Default
var saved_animation: Animations

func _ready():
	reset()


func play_deploy():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	deploy.visible = true
	anim.play("deploy")
	current_animation = Animations.Deploy


func play_selection():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	selection.visible = true
	anim.play("selection")
	current_animation = Animations.Selection


func play_move():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	move.visible = true
	anim.play("move")
	current_animation = Animations.Move


func save_current():
	saved_animation = current_animation


func reset():
	anim.stop()
	set_process(false)
	selection.visible = false
	deploy.visible = false
	move.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	current_animation = Animations.Default


func revert():
	match saved_animation:
		Animations.Selection:
			play_selection()
			continue
		Animations.Move:
			play_move()
			continue
		Animations.Deploy:
			play_deploy()
			continue
	saved_animation = -1


func _process(_delta):
	set_global_position(get_global_mouse_position())

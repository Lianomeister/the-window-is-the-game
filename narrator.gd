extends Node

var state = "start"

# position variables
var pos1 = Vector2(1373.0,857.0)
var pos2 = Vector2(884.0, 44.0)
var pos3 = Vector2(884.0, 97.0)
var pos4 = Vector2(1329.0, 62.0)
var pos5 = Vector2(1250.0, 672.0)

# Action variables
var drag := false
var start_stage = false
# sprite variables
@export var mauszeiger : Sprite2D
@export var narratorenabled := false


func _ready() -> void:
	mauszeiger.position = pos1
	if start_stage == true:
		action_start_stage()
		$"CanvasLayer/Szene1/2140".show()
		$CanvasLayer/Szene1/Panel.show()
		$"../Control/CanvasLayer".hide()
	else:
		$"CanvasLayer/Szene1/2140".hide()
		$CanvasLayer/Szene1/Panel.hide()
		$"../Control/CanvasLayer".show()

func achievement_and_actions(action):
	if action == "drag":
		drag = true

func action_start_stage():
	print("stage")
	print("Hello its me, the Narrator!")
	var tween = create_tween()
	tween.tween_property(mauszeiger, "position", pos2, 3.0)
	tween.tween_interval(0.2)
	tween.tween_callback(func():
		$CanvasLayer/Szene1/Panel.animation()
		print("now let me just quickly do this")
	)
	tween.tween_property(mauszeiger, "position", pos3, 3)
	tween.tween_property(mauszeiger, "position", pos4, 3)
	tween.tween_property(mauszeiger, "scale", Vector2(4, 4), 0.2)
	tween.tween_property(mauszeiger, "scale", Vector2(5, 5), 0.2)
	tween.tween_callback(func():
		$"CanvasLayer/Szene1/2140".hide()
		$CanvasLayer/Szene1/Panel.hide()
		$"../Control/CanvasLayer".show()
		print("exaclty what it wanted.")
	)
	tween.tween_property(mauszeiger, "position", pos5, 3)
	tween.tween_callback(func():
		print("now, try out a bit yourself!")
	)

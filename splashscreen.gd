extends Control

@export var texturerect: TextureRect

const FINAL_SIZE := Vector2(560, 560)
const START_POSITION := Vector2(-410.0, -385.0)

const START_SCALE := 0.3
const END_SCALE := 0.4
const ZOOM_TIME := 6.0


func _ready() -> void:
	texturerect.size = FINAL_SIZE
	texturerect.position = START_POSITION
	texturerect.pivot_offset = FINAL_SIZE / 2.0

	texturerect.scale = Vector2(START_SCALE, START_SCALE)
	texturerect.modulate.a = 0.0

	play_tween()


func play_tween() -> void:
	var tween := create_tween()

	tween.set_parallel(true)

	# Fade In
	tween.tween_property(
		texturerect,
		"modulate:a",
		1.0,
		ZOOM_TIME
	)

	# Langsamer, kleiner Zoom
	tween.tween_property(
		texturerect,
		"scale",
		Vector2(END_SCALE, END_SCALE),
		ZOOM_TIME
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	tween.set_parallel(false)

	# Kurz warten
	tween.tween_interval(2.0)

	# Szene wechseln
	await tween.finished
	get_tree().change_scene_to_file("res://Game.tscn")

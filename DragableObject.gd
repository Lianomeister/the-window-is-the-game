extends CharacterBody2D

var dragging := false
var drag_offset := Vector2.ZERO
@export var sprite2d : Sprite2D
@export var appmenu : CanvasLayer

func _ready():
	z_index = 1000

func check_eimer():
	if not appmenu == null:
		if dragging:
			appmenu.show_müll()
		else:
			appmenu.hide_müll()

func _process(delta: float) -> void:
	check_eimer()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos := get_global_mouse_position()

				# Prüfen, ob Maus auf dem Sprite liegt
				var sprite := sprite2d

				if sprite.get_rect().has_point(sprite.to_local(mouse_pos)):
					dragging = true
					drag_offset = global_position - mouse_pos
			else:
				dragging = false

	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + drag_offset

extends CharacterBody2D

var dragging := false
var eimer_aktiv := false
var drag_offset := Vector2.ZERO
var drag_start_position := Vector2.ZERO

const EIMER_DISTANCE := 20.0

@export var sprite2d: Sprite2D
@export var appmenu: CanvasLayer
@export var müllable := false
@export var zerfallenerlaubt := false
@export var is_dragable := true

func _ready() -> void:
	z_index = 1000


func _exit_tree() -> void:
	dragging = false
	eimer_aktiv = false


func _input(event) -> void:
	if is_dragable:
		if event is InputEventMouseButton:
			if event.button_index != MOUSE_BUTTON_LEFT:
				return

			if event.pressed:
				var mouse_pos := get_global_mouse_position()

				if sprite2d.get_rect().has_point(sprite2d.to_local(mouse_pos)):
					dragging = true
					eimer_aktiv = false
					drag_start_position = mouse_pos
					drag_offset = global_position - mouse_pos

			else:
				if dragging:
					dragging = false

					if eimer_aktiv:
						appmenu.hide_müll()
						eimer_aktiv = false


		elif event is InputEventMouseMotion and dragging:
			var mouse_pos := get_global_mouse_position()

			global_position = mouse_pos + drag_offset

			if not eimer_aktiv:
				if müllable:
					if mouse_pos.distance_to(drag_start_position) >= EIMER_DISTANCE:
						eimer_aktiv = true
						appmenu.show_müll()
	
func zerfallen() -> void:
	if zerfallenerlaubt:
		var tween := create_tween()

		tween.set_parallel(true)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN)

		tween.tween_property(self, "position", position + Vector2(0, 700), 1.5)
		tween.tween_property(self, "rotation", rotation + 1.5, 1.5)

		tween.set_parallel(false)
		tween.tween_callback(queue_free)

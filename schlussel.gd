
extends CharacterBody2D

var dragging := false
var drag_offset := Vector2.ZERO


func _ready():
	z_index = 1000


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_pos = get_global_mouse_position()

				if is_mouse_over():
					dragging = true
					drag_offset = global_position - mouse_pos

			else:
				dragging = false


func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset


func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	var shape = $CollisionShape2D.shape

	if shape is RectangleShape2D:
		var size = shape.size
		var local_pos = to_local(mouse_pos)

		return abs(local_pos.x) <= size.x / 2.0 \
			and abs(local_pos.y) <= size.y / 2.0

	elif shape is CircleShape2D:
		var local_pos = to_local(mouse_pos)

		return local_pos.length() <= shape.radius

	return false

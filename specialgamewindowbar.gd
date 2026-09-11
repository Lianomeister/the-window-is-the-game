extends Panel

var dragging := false
var drag_offset := Vector2.ZERO
var position_old := Vector2.ZERO

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if $"..".check_if_something("dragable"):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

			if dragging:
				position_old = position
				drag_offset = position - get_parent().to_local(get_global_mouse_position())
				mouse_default_cursor_shape = Control.CURSOR_DRAG
			else:
				mouse_default_cursor_shape = Control.CURSOR_ARROW

func _process(_delta):
	if dragging:
		position = get_parent().to_local(get_global_mouse_position()) + drag_offset

		var position_new = position - position_old

		if $"..".programm == "Game":
			$SubViewportContainer/SubViewport/Node2D.change_cam_pos(
				position_new.x,
				position_new.y
			)

		position_old = position

func move_window_achievement():
	await dragging
	$"../../Narrator".achievement_and_actions("drag")

extends Panel

var dragging := false
var drag_offset := Vector2.ZERO
var shakness := 5

func shaking():
	if dragging:
		# Vector2 kann nicht mit Float verglichen werden → Länge verwenden
		if drag_offset.length() >= 0.5:
			shakness = drag_offset.length()
			return shakness

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if $"..".check_if_something("dragable"):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

			if dragging:
				drag_offset = position - get_parent().to_local(get_global_mouse_position())
				mouse_default_cursor_shape = Control.CURSOR_DRAG
			else:
				mouse_default_cursor_shape = Control.CURSOR_ARROW

func _process(_delta):
	if dragging:
		position = get_parent().to_local(get_global_mouse_position()) + drag_offset
		shaking() # falls du willst, dass es live reagiert

func move_window_achievement():
	await dragging
	$"../../Narrator".achievement_and_actions("drag")

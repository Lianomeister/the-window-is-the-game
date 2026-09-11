extends Panel

var resizing := false
var size_offset := Vector2.ZERO
var breite_old

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		resizing = event.pressed
		breite_old = size.x
		if resizing:
			size_offset = position - get_viewport().get_mouse_position()
			mouse_default_cursor_shape = Control.CURSOR_DRAG
		else:
			mouse_default_cursor_shape = Control.CURSOR_ARROW
		

func _process(delta):
	if resizing:
		position = get_viewport().get_mouse_position() + size_offset

		send_to_game()
		breite_old = size.x
		
func send_to_game():
	if resizing:
		var breite_new = position - breite_old

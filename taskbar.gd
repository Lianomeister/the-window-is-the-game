extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if not $"../../CanvasLayer/Node".visible:
		$"../../CanvasLayer/Node".ausfahren()
	else:
		$"../../CanvasLayer/Node".einfahren()

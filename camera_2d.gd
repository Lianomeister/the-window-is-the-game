extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	enabled = true
	make_current()
	print("CURRENT:", is_current())
	position = Vector2(2000, 2000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = Time.get_datetime_dict_from_system()
	self.text = "%02d:%02d" % [t.hour, t.minute]

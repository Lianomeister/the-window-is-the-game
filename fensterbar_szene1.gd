extends Sprite2D
var zielpos = Vector2(382.0, -5.0)
var startpos = Vector2(382.0, -60.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = startpos
	
func animation():
	var tween = create_tween()
	tween.tween_property(self, "position", zielpos, 3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Sprite2D

var tween: Tween
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	hidemüll()


func showmüll() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:x", 1200.0, 0.6)


func hidemüll() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:x", 1428.0, 0.6)

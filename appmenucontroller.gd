extends CanvasLayer

var tween: Tween

var ausfahren_pos := Vector2(0, 0)
var einfahren_pos := Vector2(0, 500)


func einfahren() -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(
		self,
		"offset:y",
		einfahren_pos.y,
		0.6
	)

	tween.tween_callback(hide)


func ausfahren() -> void:
	show()

	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		self,
		"offset:y",
		ausfahren_pos.y,
		0.6
	)

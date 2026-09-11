
extends Button
var logoutbuttonstage := 0
var logoutbuttondingdrauf := 1
func _ready() -> void:
	$Sprite2D.show()
	$Sprite2D2.show()
	$Sprite2D3.show()
	$TextureRect.show()
	$CanvasLayer2.hide()



func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.is_in_group("logout_kappe"):
		logoutbuttondingdrauf = 1

	if body.is_in_group("key_logout"):
		body.queue_free()
		$TextureRect.hide()
		$Sprite2D3.queue_free()
		$CanvasLayer2.show()
		logoutbuttonstage = 1

	elif body.is_in_group("chip_shutdown"):
		if logoutbuttondingdrauf == 0:
			$Sprite2D3.show()
			body.queue_free()
			logoutbuttonstage = 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("logout_kappe"):
		logoutbuttondingdrauf = 0

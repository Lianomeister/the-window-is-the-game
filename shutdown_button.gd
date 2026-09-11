extends Button
var shutdownbuttonstage := 0
var schrauben_offen := 0
func _ready() -> void:
	$Sprite2D3.show()
	$"../Utility/Schraubenzieher".hide()

func _process(_delta: float) -> void:
	if schrauben_offen == 4:
		$"../Utility/CharacterBody2D".queue_free()
		$"../Utility/Schraubenzieher".show()
		$Sprite2D.show()
		$Sprite2D2.show()
		$Sprite2D3.hide()
		$buttons.hide()
		$CanvasLayer.show()
		schrauben_offen = 5

func _on_area_schraube1_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/Allebuttons.queue_free()

func _on_area_schraube2_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/Allebuttons2.queue_free()

func _on_area_schraube3_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/Allebuttons3.queue_free()

func _on_area_schraube4_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/Allebuttons4.queue_free()

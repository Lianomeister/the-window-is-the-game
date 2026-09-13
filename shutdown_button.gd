extends Button
var shutdownbuttonstage := 0
var schrauben_offen := -1
func _ready() -> void:
	$Sprite2D3.show()

func _process(_delta: float) -> void:
	if schrauben_offen == 3:
		$"../Utility/CharacterBody2D".zerfallen()
		$Sprite2D.show()
		$Sprite2D2.show()
		$Sprite2D3.hide()
		$buttons.hide()
		$CanvasLayer.show()
		schrauben_offen = 5

func _on_area_schraube1_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/CharacterBody2D2.hide()

func _on_area_schraube2_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/CharacterBody2D3.hide()

func _on_area_schraube3_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/CharacterBody2D4.hide()

func _on_area_schraube4_entered(body: Node2D) -> void:
	if body.is_in_group("schraubenzieher"):
		schrauben_offen += 1
		$buttons/CharacterBody2D.hide()

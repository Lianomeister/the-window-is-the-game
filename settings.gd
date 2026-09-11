extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_display_pressed() -> void:
	hide_all_categories()
	$CanvasLayer/Setting_screens/Display.show()


func _on_audio_pressed() -> void:
	hide_all_categories()
	$CanvasLayer/Setting_screens/Audio.show()


func _on_gameplay_pressed() -> void:
	hide_all_categories()
	$CanvasLayer/Setting_screens/Gameplay.show()


func _on_accessibility_pressed() -> void:
	hide_all_categories()
	$CanvasLayer/Setting_screens/Accesibility.show()

func hide_all_categories():
		$CanvasLayer/Setting_screens/Display.hide()
		$CanvasLayer/Setting_screens/Audio.hide()
		$CanvasLayer/Setting_screens/Gameplay.hide()
		$CanvasLayer/Setting_screens/Accesibility.hide()


func _on_Timer_timeout() -> void:
	pass # Replace with function body.


func _on_apply_pressed() -> void:
	SettingsManager.apply_settings()
	SettingsManager.save_settings()

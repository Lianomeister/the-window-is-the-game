extends ColorRect

var updating_ui := false


func _ready() -> void:
	update_ui()

func _enter_tree() -> void:
	update_ui()


func update_ui() -> void:
	updating_ui = true

	$Display/Label/Button.text = "On" if SettingsManager.Fullscreen else "Off"
	$Display/Label3/OptionButton.select(0 if SettingsManager.Windowmode == "Windowed" else 1)
	$Display/Label4/Button.text = "On" if SettingsManager.VSync else "Off"

	$Gameplay/Label3/Button.text = "On" if SettingsManager.ShowTutorials else "Off"

	$Accesibility/Label/Button.text = "On" if SettingsManager.Screenshake else "Off"
	$Accesibility/Label3/Button.text = "On" if SettingsManager.Subtitles else "Off"
	$Accesibility/Label4/Button.text = "On" if SettingsManager.FlashingEffects else "Off"

	$Audio/Label/HSlider.value = SettingsManager.MasterVolume
	$Audio/Label3/HSlider.value = SettingsManager.MusicVolume
	$Audio/Label4/HSlider.value = SettingsManager.SFXVolume
	$Audio/Label5/HSlider.value = SettingsManager.NarratorVolume

	$Gameplay/Label/HSlider.value = SettingsManager.MouseSensitivity
	$Gameplay/Label4/HSlider.value = SettingsManager.TextSpeed

	updating_ui = false


func _on_windowmode_selected(index: int) -> void:
	SettingsManager.Windowmode = "Windowed" if index == 0 else "Fullscreen"
	SettingsManager.Fullscreen = index == 1
	SettingsManager.apply_display_settings()
	update_ui()


func _on_vsync_pressed() -> void:
	SettingsManager.VSync = not SettingsManager.VSync
	SettingsManager.apply_display_settings()
	update_ui()


func _on_fullscreen_pressed() -> void:
	SettingsManager.Fullscreen = not SettingsManager.Fullscreen
	SettingsManager.Windowmode = "Fullscreen" if SettingsManager.Fullscreen else "Windowed"
	SettingsManager.apply_display_settings()
	update_ui()


func _on_Mastervolume_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.MasterVolume = value
		SettingsManager.apply_audio_settings()


func _on_Musicvolume_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.MusicVolume = value
		SettingsManager.apply_audio_settings()


func _on_sfxvolume_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.SFXVolume = value
		SettingsManager.apply_audio_settings()


func _on_narratorvolume_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.NarratorVolume = value
		SettingsManager.apply_audio_settings()


func _on_mousesensitivity_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.MouseSensitivity = value


func _on_textspeed_changed(value: float) -> void:
	if not updating_ui:
		SettingsManager.TextSpeed = value


func _on_showtutorial_pressed() -> void:
	SettingsManager.ShowTutorials = not SettingsManager.ShowTutorials
	update_ui()


func _on_screenshake_pressed() -> void:
	SettingsManager.Screenshake = not SettingsManager.Screenshake
	update_ui()


func _on_subtitles_pressed() -> void:
	SettingsManager.Subtitles = not SettingsManager.Subtitles
	update_ui()


func _on_flashingeffects_pressed() -> void:
	SettingsManager.FlashingEffects = not SettingsManager.FlashingEffects
	update_ui()


func _on_apply_pressed() -> void:
	SettingsManager.apply_settings()
	SettingsManager.save_settings()
	update_ui()

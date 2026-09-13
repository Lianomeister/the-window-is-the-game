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


func _on_shader_selected(index: int) -> void:
	var shader_rect = get_tree().current_scene.get_node("Shaderlayer/Shaderrect")

	var shader_paths = [
		null, 
		"res://addons/godot_retro/shaders/standard/tv.gdshader",
		"res://addons/godot_retro/shaders/standard/vhs.gdshader",
		"res://addons/godot_retro/shaders/standard/crt_basic.gdshader",
		"res://addons/godot_retro/shaders/standard/dithering.gdshader",
		"res://addons/godot_retro/shaders/standard/glitch_simple.gdshader",
        "res://addons/godot_retro/shaders/standard/monochrome.gdshader"
	]

	var path = shader_paths[index]

	if path == null:
		shader_rect.hide()
		return

	# Shader setzen
	shader_rect.show()
	var mat := ShaderMaterial.new()
	mat.shader = load(path)
	shader_rect.material = mat

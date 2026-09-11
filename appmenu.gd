extends CanvasLayer

@export var window := Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	var paths: Array[String] = [
		OS.get_environment("APPDATA") + "/Microsoft/Windows/AccountPictures/",
		OS.get_environment("SystemDrive") + "/ProgramData/Microsoft/User Account Pictures/"
	]

	var tex: Texture2D = null
	for pic_dir in paths:
		var dir := DirAccess.open(pic_dir)
		if dir:
			dir.list_dir_begin()
			var file_name := dir.get_next()
			while file_name != "":
				if file_name.ends_with(".png") or file_name.ends_with(".jpg") or file_name.ends_with(".bmp"):
					var img := Image.load_from_file(pic_dir + file_name)
					var temp_tex := ImageTexture.create_from_image(img)
					# Standardbilder überspringen
					if file_name.to_lower().contains("guest") or file_name.to_lower().contains("user") or file_name.to_lower().contains("admin"):
						print("Standardbild erkannt:", file_name)
					else:
						tex = temp_tex
						print("Echtes Profilbild geladen:", file_name)
						break
				file_name = dir.get_next()
			dir.list_dir_end()
		if tex:
			break

	if tex:
		$TextureRect2.texture = tex
	else:
		print("Kein echtes Profilbild gefunden – Fallback verwenden.")
		$TextureRect2.texture = load("res://R.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_11_pressed() -> void:
	$".".hide()


func _on_open_game_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Game"
	})


func _on_open_text_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Text",
	"file" : "Readme.txt"
	})


func _on_open_music_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Settings",
	"file": "Oldfunk"
	})


func _on_open_settings_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Settings"
	})


func _on_open_documents_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Files",
	"site": 2
	})


func _on_open_files_pressed() -> void:
	$"../Window".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Files",
	"site": 1
	})


func _on_shutdown_pressed() -> void:
	get_tree().quit()

func show_müll():
	$"Mülleimer".show()

func hide_müll():
	$"Mülleimer".hide()

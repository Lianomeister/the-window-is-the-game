extends Node2D

var data = {}
var file = "Readme.txt"

func _ready():
	var json_file = FileAccess.open("res://filetexts.json", FileAccess.READ)
	data = JSON.parse_string(json_file.get_as_text())

func _process(_delta) -> void:
	$CanvasLayer/Label.text = get_file_text(file)

func get_file_text(filename: String):
	for key in data:
		if key.to_lower() == filename.to_lower():
			return data[key]

	print("Datei nicht gefunden: ", filename)
	return ""

func change_to_file(whichfile):
	file = whichfile

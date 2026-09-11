extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bus = AudioServer.get_bus_index("Music")
	print("mute:", AudioServer.is_bus_mute(bus))
	print("volume_db:", AudioServer.get_bus_volume_db(bus))

	$Window.create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Game"
	})
	$Window.create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(800,250),
	"programm": "Settings"
	})
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_window_button_taskbar_pressed() -> void:
	$Window.create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(500,250),
	"programm": "Game"
	})

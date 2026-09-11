extends Node2D

@export var dragging_active := true
@export var is_minimizable := true
@export var is_closable := false
@export var window_title := "Window"
@export var programm := "Game"
@export var file := "Readme.txt"
var dragging := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_window_title(window_title)


func change_dragable_status(state):
	if state == true:
		dragging = true
	if state == false:
		dragging = false

func check_if_something(what):
	if what == "dragable":
		return dragging_active
	elif what == "minimize":
		return is_minimizable
	elif what == "closable":
		return is_closable
	else:
		return false

func change_window_title(title):
	window_title = title
	if programm == "Files":
		$Files/Label.text = window_title
	if programm == "Text":
		$Text/Label.text = window_title
	if programm == "Game":
		$Game/Label.text = window_title
	if programm == "Music":
		$Music/Label.text = window_title
	if programm == "Settings":
		$Settings/Label.text = "Settings"

func _on_panel_mouse_entered() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	if is_minimizable == true:
		self.hide()

# var copy := duplicate()
# get_parent().add_child(copy) - zum copy pasten

func create_window(settings: Dictionary):
	var copy := duplicate()

	copy.dragging_active = settings["draggable"]
	copy.is_minimizable = settings["minimizable"]
	copy.is_closable = settings["closable"]
	copy.window_title = settings["title"]
	copy.global_position = settings["position"]
	if settings["programm"] == "Game":
		copy.clear_other_than("Game")
		copy.get_node("Game").visible = true
		copy.programm = "Game"
	elif settings["programm"] == "Files":
		copy.clear_other_than("Files")
		copy.get_node("Files").visible = true
		copy.programm = "Files"
		if settings["site"] == null:
			copy.get_node("Files/SubViewportContainer/SubViewport/Fileexplorer").site = 1
		else:
			copy.get_node("Files/SubViewportContainer/SubViewport/Fileexplorer").site = settings["site"]
	elif settings["programm"] == "Text":
		copy.clear_other_than("Text")
		copy.get_node("Text").visible = true
		copy.programm = "Text"
		copy.file = settings["file"]
	elif settings["programm"] == "Settings":
		copy.clear_other_than("Settings")
		copy.get_node("Settings").visible = true
		copy.programm = "Settings"
	elif settings["programm"] == "Music":
		copy.get_node("Music").process_mode = Node.PROCESS_MODE_INHERIT
		copy.clear_other_than("Music")
		copy.get_node("Music").visible = true
		copy.programm = "Music"
		copy.get_node("Music/SubViewportContainer/SubViewport/Fileexplorer").site = settings["site"]
		copy.letmusiccheckfile()
	copy.visible = true
	get_parent().add_child(copy)

# Example use:
#create_window({
	#"draggable": true,
	#"closable": true,
	#"title": "Test"
#})

func letmusiccheckfile():
	var music = $Music/SubViewportContainer/SubViewport/Node2D
	music.file = file
	music.checkwhichfile()

func _on_button_pressed() -> void:
	if is_closable == true:
		self.queue_free()
		
func clear_other_than(program):
	if program == "Files":
		$Settings.queue_free()
		$Game.queue_free()
		$Text.queue_free()
		$Music.queue_free()
	if program == "Text":
		$Settings.queue_free()
		$Files.queue_free()
		$Game.queue_free()
		$Music.queue_free()
	if program == "Game":
		$Settings.queue_free()
		$Text.queue_free()
		$Files.queue_free()
		$Music.queue_free()
	if program == "Settings":
		$Text.queue_free()
		$Files.queue_free()
		$Game.queue_free()
		$Music.queue_free()
	if program == "Music":
		$Text.queue_free()
		$Files.queue_free()
		$Game.queue_free()
		$Settings.queue_free()

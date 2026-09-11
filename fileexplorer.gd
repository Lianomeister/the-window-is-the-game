extends Node2D

var site

func _ready() -> void:
	pass

func hideall():
	$CanvasLayer/Site1.hide()
	$CanvasLayer/Site2.hide()
	$CanvasLayer/Site3.hide()
	$CanvasLayer/Site4.hide()
	$CanvasLayer/Site5.hide()

func _enter_tree() -> void:
	showsite(1)

func _on_documents_pressed() -> void:
	showsite(2)


func _on_pictures_pressed() -> void:
	showsite(4)


func _on_oldfolder_pressed() -> void:
	showsite(3)


func _on_trash_pressed() -> void:
	showsite(5)


func _on_back_pressed() -> void:
	if site == 1:
		pass
	if site == 2:
		showsite(1)
	if site == 3:
		showsite(2)
	if site == 4:
		showsite(1)
	if site == 5:
		showsite(1)
	if site == 6:
		showsite(1)

func showsite(number):
	hideall()
	if number == 1:
		$CanvasLayer/Site1.show()
		site = 1
	if number == 2:
		$CanvasLayer/Site2.show()
		site = 2
	if number == 3:
		$CanvasLayer/Site3.show()
		site = 3
	if number == 4:
		$CanvasLayer/Site4.show()
		site = 4
	if number == 5:
		$CanvasLayer/Site5.show()
		site = 5
	if number == 6:
		$CanvasLayer/Site6.show()
		site = 6


func _on_button_19_pressed() -> void:
	open_textfile("todo.txt")


func _on_button_18_pressed() -> void:
	open_textfile("gameinfo.txt")


func _on_button_17_pressed() -> void:
	open_textfile("notes.txt")


func _on_button_16_pressed() -> void:
	open_textfile("readme.txt")


func _on_button_2_pressed() -> void:
	open_textfile("oldnotes.txt")


func _on_button_17_2_pressed() -> void:
	open_textfile("Nothing.txt")

func open_textfile(file):
	$"../../../..".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(600,200),
	"programm": "Text",
	"file": file
	})

func open_musicfile(file):
	$"../../../..".create_window({
	"draggable": true,
	"minimizable": true,
	"closable": true,
	"title": "Game",
	"position": Vector2(600,400),
	"programm": "Music",
	"file": file
	})

func _on_music_pressed() -> void:
	showsite(6)


func _on_oldfunkbutton_pressed() -> void:
	open_musicfile("Oldfunk")


func _on_oldschoolbutton_pressed() -> void:
	open_musicfile("Oldschool")


func _on_oldschoolboombutton_pressed() -> void:
	open_musicfile("Oldschoolboom")

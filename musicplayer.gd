extends Node2D

@export var audiostreamplayer : AudioStreamPlayer
@export var Sprite1 : Sprite2D
@export var Sprite2 : Sprite2D
@export var Sprite3 : Sprite2D
var file = "None"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pos = audiostreamplayer.get_playback_position()
	var len = audiostreamplayer.stream.get_length()
	$Panel/Label.text = format_time(pos) + " / " + format_time(len)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var pos = audiostreamplayer.get_playback_position()
	var len = audiostreamplayer.stream.get_length()
	if len > 0:
		var percent = pos / len * 100.0
		$Panel/ProgressBar.value = percent

func checkwhichfile():
	if file == "Oldfunk":
		audiostreamplayer.stream = load("res://assets/music/Oldfunk.mp3")
		audiostreamplayer.play()
		hideall()
		Sprite1.show()
	if file == "Oldschool":
		audiostreamplayer.stream = load("res://assets/music/oldschool.mp3")
		audiostreamplayer.play()
		hideall()
		Sprite2.show()
	if file == "Oldschoolboom":
		audiostreamplayer.stream = load("res://assets/music/Oldschoolboom.mp3")
		audiostreamplayer.play()
		hideall()
		Sprite3.show()
	if file == "None":
		audiostreamplayer.stop()
		hideall()


func hideall():
	Sprite1.hide()
	Sprite2.hide()
	Sprite3.hide()
	
func format_time(t):
	var minutes = int(t / 60)
	var seconds = int(t) % 60
	return str(minutes) + ":" + str(seconds).pad_zeros(2)


func _on_play_pressed() -> void:
	if audiostreamplayer.get_playback_position() < 1:
		audiostreamplayer.play()
	else:
		audiostreamplayer.stream_paused = false


func _on_stop_pressed() -> void:
	audiostreamplayer.stop()


func _on_pause_pressed() -> void:
	if audiostreamplayer.stream_paused == true:
		audiostreamplayer.stream_paused = false
	else:
		audiostreamplayer.stream_paused = true

extends Node2D

var file := "res://assets/schliesenbutton.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if file.ends_with(".mp4"):
		$CanvasLayer/VideoStreamPlayer.show()
		$CanvasLayer/TextureRect.hide()
		$VideoStreamPlayer.stream = load(file)
	else:
		$CanvasLayer/TextureRect.show()
		$CanvasLayer/VideoStreamPlayer.hide()
		$TextureRect.texture = load(file)

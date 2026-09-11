extends Node2D

var rechts
var links
var oben
var unten
var rechts_area
var links_area
var oben_area
var unten_area
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.remove_from_group("is_visible")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_cam_pos(x, y):
	$Camera2D.position += Vector2(x, y)
func change_cam_pos_absoloute(x, y):
	$Camera2D.position =  $Camera2D.to_local(Vector2(x, y))


func _on_visible_on_screen_notifier_2d_screen_entered():
	print("sichtbar")
	$Sprite2D.add_to_group("was_visible")
	$Sprite2D.add_to_group("is_visible")
	print($Sprite2D.get_groups())


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("unsichtbar")
	$Sprite2D.remove_from_group("is_visible")

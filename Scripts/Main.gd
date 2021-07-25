extends Spatial

var Key = preload("res://Scenes/Key.tscn")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if Input.is_action_just_pressed("inventory"):
		get_tree().paused = !get_tree().is_paused()
		if get_tree().is_paused():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func spawn_key(name):
	var key = Key.instance()
	match name:
		"Red_Key":
			key.color = "Red"
			key.name = "Red_Key"
		"Green_Key":
			key.color = "Green"
			key.name = "Green_Key"
		"Blue_Key":
			key.color = "Blue"
			key.name = "Blue_Key"
	add_child(key)
	key.transform.origin = $Player.transform.origin
	key.transform.origin.x += rand_range(-0.5, +0.5)

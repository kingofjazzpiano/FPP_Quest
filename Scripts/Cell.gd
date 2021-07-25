extends TextureRect

var in_cell = false
var key_name = null


func _physics_process(delta):
	if in_cell and Input.is_action_just_pressed("L_CLICK"):
		get_node("/root/Main/GUI")._on_cell_mouse_click($TextureRect)
		in_cell = false


func _on_Ceil_mouse_entered():
	in_cell = true

extends CanvasLayer

onready var Line_1 = $Debug_Panel/Label_1
onready var Line_2 = $Debug_Panel/Label_2
onready var Line_3 = $Debug_Panel/Label_3
onready var Line_4 = $Debug_Panel/Label_4
onready var Line_5 = $Debug_Panel/Label_5

enum {OPEN, CLOSED}
onready var doors = {"Red": CLOSED, "Blue": CLOSED, "Green": CLOSED}

var Keys = {
	"Red_Key": preload("res://Assets/Textures/key01.png"),
	"Green_Key": preload("res://Assets/Textures/key02.png"),
	"Blue_Key": preload("res://Assets/Textures/key03.png")
}

enum {EQUIPPED, EMPTY, BUSY}
onready var Cell_1 = $Inventory/Cell_1/TextureRect
onready var Cell_2 = $Inventory/Cell_2/TextureRect
onready var inventory = {Cell_1: EMPTY, Cell_2: EMPTY}
var Active_Cell_Texture = preload("res://Assets/Textures/active_cell.png")
var Cell_Texture = preload("res://Assets/Textures/inventory_cell.png")
var active_cell = null

onready var Player = $"/root/Main/Player"


func _ready():
	$PopupMenu.add_item("Equip", 0)
	$PopupMenu.add_item("Drop", 1)


func _physics_process(delta):
	Line_1.text = "Cell_1 " + str(inventory[Cell_1])
	Line_2.text = "Cell_2 " + str(inventory[Cell_2])
	if active_cell:
		Line_3.text = "active_cell " + str(inventory[active_cell])
	Line_4.text = "HAND " + str(Player.hand)


func take_thing(object):
	for _cell in inventory:
		if inventory[_cell] == EMPTY:
			inventory[_cell] = BUSY
			_cell.texture = Keys[object.name]
			_cell.get_parent().key_name = object.name
			object.queue_free()
			break


func _on_PopupMenu_id_pressed(id):
	var key_name = active_cell.get_parent().key_name
	if id == EMPTY:
		get_node("/root/Main").spawn_key(key_name)
		if inventory[active_cell] == EQUIPPED:
			Player.hand = null
		inventory[active_cell] = EMPTY
		active_cell.texture = null
		active_cell.get_parent().texture = Cell_Texture
	if id == EQUIPPED:
		for _cell in inventory:
			if (_cell != active_cell):
				if inventory[_cell] == EQUIPPED:
					inventory[_cell] = BUSY
				_cell.get_parent().texture = Cell_Texture
		match key_name:
			"Red_Key":
				Player.hand = "Red"
			"Green_Key":
				Player.hand = "Green"
			"Blue_Key":
				Player.hand = "Blue"
		inventory[active_cell] = EQUIPPED
		active_cell.get_parent().texture = Active_Cell_Texture


func _on_cell_mouse_click(cell_n):
	if inventory[cell_n] == BUSY\
	or inventory[cell_n] == EQUIPPED:
		active_cell = cell_n
		$PopupMenu.popup()


func _input(event):
	if Input.is_action_just_pressed("inventory"):
		$PopupMenu.hide()


func check_for_win():
	if inventory[active_cell] == EQUIPPED:
		Player.hand = null
	inventory[active_cell] = EMPTY
	active_cell.texture = null
	active_cell.get_parent().texture = Cell_Texture
	for stat in doors.values():
		if stat == CLOSED:
			return
	$You_Win.visible = true
	$Aim.visible = false

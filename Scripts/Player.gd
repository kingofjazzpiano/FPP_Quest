extends KinematicBody

enum {OPEN, CLOSED}

onready var GUI = $"/root/Main/GUI"

const GRAVITY = -100
var rotation_y = 0
var rotation_x = 0
var rotation_speed = 0.07
var speed = 10
var g_delta = 0
var velocity = Vector3()

var hand = null

func _physics_process(delta):
	g_delta = delta

	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity.normalized() * speed, Vector3.UP)

	if $Camera/RayCast.is_colliding():
		var collider = $Camera/RayCast.get_collider().get_parent()
		if Input.is_action_just_pressed("interact"):
			if 'Key' in collider.name:
				GUI.take_thing(collider)
			elif 'Door' in collider.name and hand:
				var door = collider.get_node("Door")
				if hand == door.color:
					door.paint(Color.green)
					door.get_node("APlayer").play("opening")
					GUI.doors[hand] = OPEN
					GUI.check_for_win()
				else:
					door.paint(Color.red)


func _input(event):
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * rotation_speed * g_delta
		rotation_x -= event.relative.y * rotation_speed * g_delta
		rotation_x = clamp(rotation_x, -PI/2, PI/2)
		transform.basis = Basis(Vector3.UP, rotation_y)
		$Camera.transform.basis = Basis(Vector3.RIGHT, rotation_x)
	
	velocity = Vector3()
	if Input.is_action_pressed("Forward"):
		velocity -= transform.basis.z
	if Input.is_action_pressed("Backward"):
		velocity += transform.basis.z
	if Input.is_action_pressed("Left"):
		velocity -= transform.basis.x
	if Input.is_action_pressed("Right"):
		velocity += transform.basis.x

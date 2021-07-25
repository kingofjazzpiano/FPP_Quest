extends Spatial

export (String) var color


func _ready():
	var red_material = SpatialMaterial.new()
	red_material.albedo_color = Color.red
	var blue_material = SpatialMaterial.new()
	blue_material.albedo_color = Color.blue
	var green_material = SpatialMaterial.new()
	green_material.albedo_color = Color.green
	if color == "Red":
		$CSGTorus/CSGBox.set_material(red_material)
		$CSGTorus/CSGBox2.set_material(red_material)
		$CSGTorus/CSGCylinder.set_material(red_material)
		$CSGTorus.set_material(red_material)
	if color == "Blue":
		$CSGTorus/CSGBox.set_material(blue_material)
		$CSGTorus/CSGBox2.set_material(blue_material)
		$CSGTorus/CSGCylinder.set_material(blue_material)
		$CSGTorus.set_material(blue_material)
	if color == "Green":
		$CSGTorus/CSGBox.set_material(green_material)
		$CSGTorus/CSGBox2.set_material(green_material)
		$CSGTorus/CSGCylinder.set_material(green_material)
		$CSGTorus.set_material(green_material)

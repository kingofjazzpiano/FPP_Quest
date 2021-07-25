extends StaticBody

export (String) var color

onready var self_material = $MeshInstance.get_surface_material(0)


func paint(new_color):
	var temporary_material = SpatialMaterial.new()
	temporary_material.albedo_color = new_color
	$MeshInstance.set_surface_material(0, temporary_material)
	$Timer.start()


func _on_Timer_timeout():
	$MeshInstance.set_surface_material(0, self_material)


func _on_APlayer_animation_finished(anim_name):
	queue_free()

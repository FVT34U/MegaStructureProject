extends Node3D
class_name Linker

static func link(A: Node3D, B: Node3D):
	if not A.has_meta("Size") or not B.has_meta("Size"):
		return
	
	var a_connector := A.get_node("Connector") as Node3D
	var b_connector := B.get_node("Connector") as Node3D
	
	B.global_transform = a_connector.global_transform *\
		b_connector.transform.affine_inverse()

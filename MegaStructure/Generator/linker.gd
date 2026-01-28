extends Node3D
class_name Linker

static func link(A: Node3D, B: Node3D):
	if not A.has_meta("Size") or not B.has_meta("Size"):
		return
	
	var a_connector := A.get_node("Connector") as Node3D
	var b_connector := B.get_node("Connector") as Node3D
	
	var a_c_dir := a_connector.get_meta("Direction", Vector3.ZERO) as Vector3
	if a_c_dir == Vector3.ZERO:
		return
	a_c_dir = a_c_dir.normalized()
	
	var b_c_dir := b_connector.get_meta("Direction", Vector3.ZERO) as Vector3
	if b_c_dir == Vector3.ZERO:
		return
	b_c_dir = b_c_dir.normalized()
	
	# A.Direction (global)
	var a_dir_global := (
		a_connector.global_transform.basis
		* a_c_dir
	).normalized()

	# B.Direction (global)
	var b_dir_global := (
		b_connector.global_transform.basis
		* b_c_dir
	).normalized()

	# Поворот: B_dir -> -A_dir
	var q := Quaternion(b_dir_global, -a_dir_global)

	var b_rotation := Transform3D(Basis(q), Vector3.ZERO)
	
	B.global_transform =\
		a_connector.global_transform\
		* b_rotation\
		* b_connector.transform.affine_inverse()

extends StaticBody3D  # atau node tipe lain sesuai di scene

func _ready():
	# Path absolut dari root scene ke MeshInstance3D
	var path = "/root/SceneRoot/Sketchfab_model/255fbab5dde44acfb90af7ddff2423e5_fbx/RootNode/Cube"
	
	# Coba ambil node dengan path absolut
	var mesh_instance = get_node_or_null(path)
	
	if mesh_instance == null:
		print("Node mesh tidak ditemukan di path: ", path)
		return
	
	if not mesh_instance is MeshInstance3D:
		print("Node bukan MeshInstance3D: ", mesh_instance.name)
		return
	
	var mesh = mesh_instance.mesh
	if mesh == null or mesh.get_surface_count() == 0:
		print("Mesh kosong atau tidak valid pada node: ", mesh_instance.name)
		return
	
	# Buat collider ConvexPolygonShape3D dari mesh
	var shape = ConvexPolygonShape3D.new()
	shape.data = mesh
	
	# Pasang collider ke child CollisionShape3D, pastikan node ini punya child CollisionShape3D
	var collision_shape = $CollisionShape3D
	if collision_shape:
		collision_shape.shape = shape
		print("Collider berhasil dibuat dari mesh ", mesh_instance.name)
	else:
		print("CollisionShape3D tidak ditemukan sebagai child node")

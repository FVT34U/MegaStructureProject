extends Node3D

@export var A: Node3D
@export var B: Node3D


func _ready() -> void:
	Linker.link(A, B)


func _process(_delta: float) -> void:
	pass

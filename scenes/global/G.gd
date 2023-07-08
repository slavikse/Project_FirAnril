extends Node3D

# todo game name
#const _LEVELS_FILE_NAME := "user://Project_stealth.pixsynt"

@onready var _scene_tree := get_tree() as SceneTree
#@onready var root_node := $'/root' as Viewport
#@onready var world_node := get_world_3d() as World3D

func scene_paused(flag: bool) -> void:
    _scene_tree.paused = flag

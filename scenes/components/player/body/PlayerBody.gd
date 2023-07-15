extends Area3D
class_name PlayerBody

var _gravitation_script := preload('./scripts/gravitation.gd').new()
var _movement_script := preload('./scripts/movement.gd').new()
var _is_bounce_buffer := false

# todo звук скольжения по стене (царапает?)

func movement(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    velocity = _gravitation_script.gravitation(is_floor, is_wall, velocity, delta)
    return _movement_script.apply_to_movement(move_direction, velocity, delta)

# todo Floors Walls
func _on_body_entered(barrier_node: StaticBody3D) -> void:
    if barrier_node.is_in_group(GConst.GROUPS.floor):
        print('_on_body_entered')
        _is_bounce_buffer = true
    elif barrier_node.is_in_group(GConst.GROUPS.brickColumn):
        pass

func _on_body_exited(barrier_node: StaticBody3D) -> void:
    if barrier_node.is_in_group(GConst.GROUPS.floor):
        print('_on_body_exited')
        _is_bounce_buffer = false
    elif barrier_node.is_in_group(GConst.GROUPS.brickColumn):
        pass

# todo стоя возле стены, не срабатывает триггер пересечения с буффером
# todo уменьшить буффер коллизии, когда будет решена задача
func has_bounce_buffer(is_floor: float) -> bool:
    # ввести is_floor_prev - если стоит на земле, то prev false.
    # _is_bounce_buffer не будет принудительно сбрасываться, пока игрок стоит на земле?
    # если _is_bounce_buffer and is_floor == true значит принудительно не сбрасываем
#    if not (is_floor and _is_bounce_buffer):
#        _is_bounce_buffer = false

    if is_floor:
        return false or _is_bounce_buffer

    return _is_bounce_buffer

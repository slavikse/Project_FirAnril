func get_move_direction(t_basis: Basis) -> Vector3:
    var input_dir := Input.get_vector('move_left', 'move_right', 'move_forward', 'move_back')
    return (t_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

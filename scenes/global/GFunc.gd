extends Node3D

# Универсальная функция типа: при присвоении преобразовать в нужный тип.
func get_random_value_from_list(list: Array):
    return list[GNumber.get_random_range_int(0, len(list) - 1)]

# Можно использовать если не важна точность до 0.1
# Создаёт и запускает таймер. Нужно вызвать уничтожение таймера,
# который передаётся в функцию func_name первым аргументом.
#func timer_start(wait_time: float, node: Object, func_name: String) -> void:
#    var timer_node := Timer.new()
#    G.root_node.call_deferred('add_child', timer_node)
#    timer_node.wait_time = wait_time
#    timer_node.one_shot = true
#    timer_node.autostart = true
#    #warning-ignore:RETURN_VALUE_DISCARDED
##    timer_node.connect('timeout', node, func_name, [timer_node])

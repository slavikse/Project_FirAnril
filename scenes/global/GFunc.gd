extends Node

# Получает случайное число из переданного списка.
func get_random_value_from_list(list: Array):
    return list[GNumber.get_random_range_int(0, len(list) - 1)]

# Создаёт и запускает таймер с функцией колбеком (wait_time: seconds).
func delay_call(wait_time: float, callback: Callable) -> void:
    var timer_node := Timer.new()
    timer_node.wait_time = wait_time
    timer_node.one_shot = true
    timer_node.autostart = true
    G.root_node.call_deferred('add_child', timer_node)
    await timer_node.timeout
    timer_node.queue_free()
    callback.call()

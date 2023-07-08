extends Node3D

# Универсальная функция типа: при присвоении преобразовать в нужный тип.
func get_random_value_from_list(list: Array):
    return list[GNumber.get_random_range_int(0, len(list) - 1)]

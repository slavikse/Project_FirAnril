extends Node

#const PLAYER_COLLISON_MASK := 0x00000001
#const WALL_COLLISON_MASK := 0x00000004
#const PLAYER_WALL_COLLISON_MASK := 0x00000005

var _random_generator := RandomNumberGenerator.new()

func get_random_range_float(from: float, to: float) -> float:
    _random_generator.randomize()
    return _random_generator.randf_range(from, to)

func get_random_range_int(from: int, to: int) -> int:
    _random_generator.randomize()
    return _random_generator.randi_range(from, to)

func get_round_to_decimal(value: float, digits: int) -> float:
    var numbers := pow(10, digits)
    return round(value * numbers) / numbers

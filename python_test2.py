def add_atms(current_count, append_count, atm_distances):
    result = []
    new_distances = [1 for i in range(current_count - 1)]

    while append_count > 0:
        temp_distances = [atm_distances[i] / new_distances[i] for i in range(current_count - 1)]
        max_value = max(temp_distances)
        max_index = temp_distances.index(max_value)
        new_distances[max_index] += 1
        append_count -= 1

    for i in range(current_count - 1):
        result.extend([round(atm_distances[i] / new_distances[i], 1) for j in range(new_distances[i])])

    return result


n = 5
k = 3
distances = [100, 30, 20, 80]
new_dist = add_atms(n, k, distances)
print(new_dist)

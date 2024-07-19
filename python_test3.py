def max_concatenated_number(str_list):
    sorted_list = sorted(str_list, key=lambda x: x * 3, reverse=True)
    return int(''.join(sorted_list))


string_list = ['4', '41', '89', '0005']
max_number = max_concatenated_number(string_list)
print(max_number)

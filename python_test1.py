import re

def convert_good_numbers(string):
    pattern = r'\b(\d{2,4}\\\d{2,5})\b'
    good_numbers = re.findall(pattern, string)
    
    for number in good_numbers:
        parts = number.split('\\')
        good_number = f'{parts[0]:0>4}\\{parts[1]:0>5}'
        print(good_number)

# 'Адрес 5467\456. Номер 405\549'
input_string = input()
convert_good_numbers(input_string)
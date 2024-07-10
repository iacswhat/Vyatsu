

def modinv(a, m):
    m0, x0, x1 = m, 0, 1
    while a > 1:
        q = a // m
        m, a = a % m, m
        x0, x1 = x1 - q * x0, x0
    return x1 + m0 if x1 < 0 else x1

def generate_keys(p, q):
    n = p * q
    phi_n = (p - 1) * (q - 1)
    
    # Выбираем открытую экспоненту e (обычно это простое число Ферма)
    e = 65537
    
    # Находим закрытую экспоненту d
    d = modinv(e, phi_n)
    
    return (e, n), (d, n)


# Простые числа
p = 577
q = 457

# Генерация ключей
public_key, private_key = generate_keys(p, q)

print(public_key, "\n", private_key)


def encrypt(message, public_key):
    print(public_key)
    e, n = public_key
    encrypted_message = [pow(ord(char), e, n) for char in message]
    return encrypted_message


str = "65537 263689"

input_text = "Но никто не знает, что самое большое счастье — в понимании."

print(encrypt(input_text, public_key))


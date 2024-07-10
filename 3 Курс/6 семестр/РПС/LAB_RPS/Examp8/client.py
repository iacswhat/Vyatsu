import xmlrpc.client

s = xmlrpc.client.ServerProxy('http://localhost:8000')
print(s.pow(2,3))  # Возвращает 2**3 = 8
print(s.add(2,3))  # Возвращает 5
print(s.mul(5,2))  # Возвращает 5*2 = 10

# Печать списка доступных методов
print(s.system.listMethods())

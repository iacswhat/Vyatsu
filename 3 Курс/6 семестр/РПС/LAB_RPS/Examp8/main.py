from xmlrpc.server import SimpleXMLRPCServer
from xmlrpc.server import SimpleXMLRPCRequestHandler

# Ограничьте доступ определенным путем.
class RequestHandler(SimpleXMLRPCRequestHandler):
    rpc_paths = ('/RPC2',)

# Создать сервер
with SimpleXMLRPCServer(('localhost', 8000),
                        requestHandler=RequestHandler) as server:
    server.register_introspection_functions()

    # Регистрация функции pow(); она будет использовать значение pow.__name__ в
    # качестве имени, которое просто "pow".
    server.register_function(pow)

    # Зарегистрировать функцию под другим именем
    def adder_function(x, y):
        return x + y
    server.register_function(adder_function, 'add')

    # Регистрация сущности; все методы сущности публикуются как методы XML-RPC (в
    # данном случае просто 'mul').
    class MyFuncs:
        def mul(self, x, y):
            return x * y

    server.register_instance(MyFuncs())

    # Запустить основной цикл сервера
    server.serve_forever()
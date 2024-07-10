from xmlrpc.server import SimpleXMLRPCServer


with SimpleXMLRPCServer(('localhost', 8080)) as server:

    server.register_function(lambda main_num, sec_num: main_num * sec_num, 'multiply_num')
    server.register_function(lambda main_den, sec_den: main_den * sec_den, 'multiply_den')

    server.register_function(lambda main_num, sec_den: main_num * sec_den, 'divide_num')
    server.register_function(lambda main_den, sec_num: main_den * sec_num, 'divide_den')

    server.register_function(lambda main_num, sec_num: main_num + sec_num, 'sum_num')
    server.register_function(lambda main_num, sec_num: main_num - sec_num, 'sub_num')

    server.register_function(lambda main_num, sec_den: main_num * sec_den, 'num_main')
    server.register_function(lambda main_den, sec_num: sec_num * main_den, 'num_sec')

    server.serve_forever()


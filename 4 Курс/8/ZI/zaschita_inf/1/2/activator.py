import requests
import hashlib
import psutil


def get_mac_address():
    try:
        mac = psutil.net_if_addrs()['Wi-Fi'][0].address
    except KeyError:
        try:
            mac = psutil.net_if_addrs()['Ethernet'][0].address 
        except KeyError:
            mac = 'unknown'
    return mac

def generate_license_key(mac_address):
    key = mac_address.encode('utf-8')
    hashed_key = hashlib.sha256(key).hexdigest()
    return hashed_key

def activate_program():
    url = 'http://127.0.0.1:5000/activate'
    hardware_id = get_mac_address()
    license_key = generate_license_key(hardware_id)
    data = {'license_key': license_key}
    response = requests.post(url, json=data)
    if response.status_code == 200:
        activation_result = response.json()
        if activation_result['success']:
            print("Программа успешно активирована.")
        else:
            print("Не удалось активировать программу:", activation_result['message'])
    else:
        print("Не удалось подключиться к серверу активации.")

if __name__ == "__main__":
    activate_program()

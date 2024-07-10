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

def check_activation():
    url = 'http://127.0.0.1:5000/check_activation'
    hardware_id = get_mac_address()
    license_key = generate_license_key(hardware_id)
    data = {'license_key': license_key}
    response = requests.post(url, json=data)
    if response.status_code == 200:
        activation_result = response.json()
        if activation_result['activated']:
            print("Программа активирована на данном компьютере.")
        else:
            print("Программа не активирована на данном компьютере. Обратитесь к администратору.")
    else:
        print("Не удалось подключиться к серверу активации.")

if __name__ == "__main__":
    check_activation()

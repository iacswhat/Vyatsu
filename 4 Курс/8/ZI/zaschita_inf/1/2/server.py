from flask import Flask, request, jsonify

def print_database():
    print("======================================================\n")
    print("Current database:")
    for key, value in activation_status.items():
        print(f"License key: {key}")
    print("======================================================\n")

app = Flask(__name__)

activation_status = {}

@app.route('/activate', methods=['POST'])
def activate():
    data = request.get_json()
    license_key = data.get('license_key')

    if license_key in activation_status:
        return jsonify({"success": False, "message": "License key already activated"})

    activation_status[license_key] = license_key

    print_database() 
    
    return jsonify({"success": True, "message": "Activation successful"})

@app.route('/check_activation', methods=['POST'])
def check_activation():
    data = request.get_json()
    license_key = data.get('license_key')

    if license_key in activation_status:
        if activation_status[license_key] == license_key:
            return jsonify({"activated": True})
        else:
            return jsonify({"activated": False, "message": "This license key is activated on another device"})
    else:
        return jsonify({"activated": False, "message": "License key is not activated"})

if __name__ == '__main__':
    app.run()

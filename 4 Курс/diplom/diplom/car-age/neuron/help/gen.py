import random

def save_data_to_file(data, filename):
    with open(filename, 'w') as f:
        for sample in data:
            f.write(','.join(map(str, sample)) + '\n')

def generate_data(num_samples):
    car_brands = ["Ford", "Toyota", "Chevrolet", "Honda", "BMW", "Mercedes-Benz", "Volkswagen", "Audi", "Nissan", "Hyundai", "LADA", "Kia", "Volvo", "Subaru", "Mazda", "Jaguar", "Porsche", "Ferrari", "Lamborghini"]
    car_models = {
        "Ford": ["Focus", "Fiesta", "Mustang", "Escape", "Explorer", "Fusion"],
        "Toyota": ["Corolla", "Camry", "Rav4", "Prius", "Highlander", "Tacoma"],
        "Chevrolet": ["Spark", "Cruze", "Malibu", "Traverse", "Silverado", "Equinox"],
        "Honda": ["Civic", "Accord", "CR-V", "Pilot", "Odyssey", "Fit"],
        "BMW": ["3 Series", "5 Series", "X3", "X5", "7 Series", "X1"],
        "Mercedes-Benz": ["C-Class", "E-Class", "GLC", "GLE", "S-Class", "A-Class"],
        "Volkswagen": ["Golf", "Passat", "Jetta", "Tiguan", "Atlas", "Beetle"],
        "Audi": ["A4", "A6", "Q5", "Q7", "Q3", "A3"],
        "Nissan": ["Altima", "Sentra", "Rogue", "Pathfinder", "Versa", "Maxima"],
        "Hyundai": ["Elantra", "Sonata", "Santa Fe", "Tucson", "Kona", "Accent"],
        "LADA": ["Granta", "Kalina", "Vesta", "XRAY", "Niva", "Priora"],
        "Kia": ["Rio", "Optima", "Sportage", "Sorento", "Soul", "Stinger"],
        "Volvo": ["S60", "XC60", "S90", "XC90", "V60", "V90"],
        "Subaru": ["Impreza", "Legacy", "Outback", "Forester", "Crosstrek", "WRX"],
        "Mazda": ["Mazda3", "Mazda6", "CX-5", "CX-9", "MX-5", "RX-8"],
        "Jaguar": ["XE", "XF", "XJ", "F-Pace", "E-Pace", "I-Pace"],
        "Porsche": ["911", "Panamera", "Cayenne", "Macan", "Boxster", "Cayman"],
        "Ferrari": ["458", "488", "812", "GTC4Lusso", "Portofino", "SF90 Stradale"],
        "Lamborghini": ["Huracan", "Aventador", "Urus", "Sian", "Centenario", "Reventon"]
    }
    data = []
    for _ in range(num_samples):
        brand = random.choice(car_brands)
        model = random.choice(car_models[brand])
        car_type = random.choice(["легковой автомобиль хэтчбэк", "легковой автомобиль седан", "кроссовер", "минивэн"])
        age = random.randint(18, 70)
        data.append((f"{brand} {model}", car_type, age))
    return data

# Генерация данных
num_samples = 1000  # Количество сгенерированных примеров
generated_data = generate_data(num_samples)

# Запись данных в файл
save_data_to_file(generated_data, 'generated_data.csv')

print("Данные успешно записаны в файл 'generated_data.csv'.")
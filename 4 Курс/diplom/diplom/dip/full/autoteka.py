from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait  # Импортируем WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# Путь к драйверу
driver_path = 'drv/chromedriver-win64/chromedriver.exe'

# URL-ссылка на страницу
website_url = 'https://autoteka.ru/'

# Инициализация драйвера
chrome_service = webdriver.chrome.service.Service(driver_path)
driver = webdriver.Chrome(service=chrome_service)

# Функция для парсинга
def site(number):
    input = number
    driver.get(website_url)

    input_field = driver.find_element(By.NAME, 'identifier')
    input_field.send_keys(input)
    input_field.send_keys(Keys.ENTER)

    WebDriverWait(driver, 15).until(EC.url_changes(website_url))

    time.sleep(5)

    text_element = driver.find_element(By.CLASS_NAME, 'pit4K')
    text = text_element.text

    time.sleep(5)

    lines = text.split('\n')
    result = ' '.join(lines[:2])

    driver.quit()

    return result.split(',')[0].strip()

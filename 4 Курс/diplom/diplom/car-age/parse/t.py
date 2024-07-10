from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait  # Импортируем WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

driver_path = 'drv/chromedriver-win64/chromedriver.exe'

website_url = 'https://www.nomerogram.ru/'

input_series1 = 'Е'
input_number = '210'
input_series2 = 'НМ'
input_region = '799'

chrome_service = webdriver.chrome.service.Service(driver_path)

driver = webdriver.Chrome(service=chrome_service)

driver.get(website_url)

input_field_series1 = driver.find_element(By.NAME, 'series1')
input_field_number = driver.find_element(By.NAME, 'number')
input_field_series2 = driver.find_element(By.NAME, 'series2')
input_field_region = driver.find_element(By.NAME, 'region')

input_field_series1.send_keys(input_series1)
time.sleep(2)
input_field_number.send_keys(input_number)
time.sleep(2)
input_field_series2.send_keys(input_series2)
time.sleep(2)
input_field_region.send_keys(input_region)
time.sleep(2)
print("1")

button = driver.find_element(By.CLASS_NAME, 'ng-button_load-cont')

print("2")
time.sleep(2)
button.click()

print("3")

#WebDriverWait(driver, 15).until(EC.url_changes(website_url))

time.sleep(10)

#output_text = driver.find_element(By.CLASS_NAME, 'car_info__title')
#print("Текст на экране:", output_text.text)

#driver.quit()

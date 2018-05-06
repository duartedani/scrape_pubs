#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Raspagem com selenium
Script: Neylson Crepalde
"""

from selenium import webdriver
import time
import pandas as pd

driver = webdriver.Firefox()

driver.get("https://www.facebook.com")
email = driver.find_element_by_id("email")
pwd = driver.find_element_by_id("pass")

email.send_keys("xxxxxx")
pwd.send_keys("xxxxxxxx")

driver.find_element_by_id("u_0_2").click()


# Raspando o Rancho Fundo
driver.get("https://www.facebook.com/RestauranteRanchoFundo/reviews")

# Rolando a página até o final
SCROLL_PAUSE_TIME = 12

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

for i in range(20):
    # Scroll down to bottom
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

    # Wait to load page
    time.sleep(SCROLL_PAUSE_TIME)

    # Calculate new scroll height and compare with last scroll height
    new_height = driver.execute_script("return document.body.scrollHeight")
    if new_height == last_height:
        break
    last_height = new_height
    
    
tags = driver.find_elements_by_class_name("userContent")
len(tags)

comentarios = []
for tag in tags:
    comentarios.append(tag.text)

comentarios[5]

dados = {'pagina': "Rancho Fundo",
         'texto': comentarios,
         'plataforma': 'Facebook'}

bd = pd.DataFrame.from_dict(dados)

bd.to_csv("rancho_fundo_comentarios_facebook.csv")


#### Raspando República da Esbórnia
driver.get("https://www.facebook.com/pg/RepublicaDaEsbornia/reviews/")

# Rolando a página até o final
SCROLL_PAUSE_TIME = 12

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

for i in range(20):
    # Scroll down to bottom
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

    # Wait to load page
    time.sleep(SCROLL_PAUSE_TIME)

    # Calculate new scroll height and compare with last scroll height
    new_height = driver.execute_script("return document.body.scrollHeight")
    if new_height == last_height:
        break
    last_height = new_height
    
    
tags = driver.find_elements_by_class_name("userContent")
len(tags)

comentarios = []
for tag in tags:
    comentarios.append(tag.text)

comentarios[2]

dados = {'pagina': "República da Esbórnia",
         'texto': comentarios,
         'plataforma': 'Facebook'}

bd = pd.DataFrame.from_dict(dados)

bd.to_csv("republica_esbornia_comentarios_facebook.csv")


# Raspando Piu Braziliano
driver.get("https://www.facebook.com/pg/PiuBraziliano/reviews/")

# Rolando a página até o final
SCROLL_PAUSE_TIME = 12

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

for i in range(20):
    # Scroll down to bottom
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

    # Wait to load page
    time.sleep(SCROLL_PAUSE_TIME)

    # Calculate new scroll height and compare with last scroll height
    new_height = driver.execute_script("return document.body.scrollHeight")
    if new_height == last_height:
        break
    last_height = new_height
    
    
tags = driver.find_elements_by_class_name("userContent")
len(tags)

comentarios = []
for tag in tags:
    comentarios.append(tag.text)

comentarios[0]

dados = {'pagina': "Piu Braziliano",
         'texto': comentarios,
         'plataforma': 'Facebook'}

bd = pd.DataFrame.from_dict(dados)

bd.to_csv("piu_braziliano_comentarios_facebook.csv")


# Raspando Boi Werneck
driver.get("https://www.facebook.com/pg/boiwerneck/reviews/")

# Rolando a página até o final
SCROLL_PAUSE_TIME = 12

# Get scroll height
last_height = driver.execute_script("return document.body.scrollHeight")

for i in range(20):
    # Scroll down to bottom
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")

    # Wait to load page
    time.sleep(SCROLL_PAUSE_TIME)

    # Calculate new scroll height and compare with last scroll height
    new_height = driver.execute_script("return document.body.scrollHeight")
    if new_height == last_height:
        break
    last_height = new_height
    
    
tags = driver.find_elements_by_class_name("userContent")
len(tags)

comentarios = []
for tag in tags:
    comentarios.append(tag.text)

comentarios[2]

dados = {'pagina': "Boi Werneck",
         'texto': comentarios,
         'plataforma': 'Facebook'}

bd = pd.DataFrame.from_dict(dados)

bd.to_csv("boi_werneck_comentarios_facebook.csv")

# Acabou. Fecha o driver
driver.close()
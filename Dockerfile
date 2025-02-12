# Используем официальный образ Python 3.9 slim в качестве базового
FROM python:3.9-slim

# Устанавливаем необходимые системные пакеты
RUN apt-get update && apt-get install -y --no-install-recommends \ 
   build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл requirements.txt в контейнер
COPY requirements.txt .

# Устанавливаем Python-библиотеки из requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем Jupyter Notebook
RUN pip install --no-cache-dir notebook

# Пробрасываем порт 8888
EXPOSE 8888

# Определяем команду запуска Jupyter Notebook с параметрами для подключения с внешней сети
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
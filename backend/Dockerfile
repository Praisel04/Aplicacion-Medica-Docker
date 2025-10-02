# 1) Base Ubuntu
FROM ubuntu:24.04

# 2) Evitar prompts y mejorar logs de Python
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3) Instalar Python y utilidades mínimas
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*

# 4) Carpeta de la app
WORKDIR /app

# 5) Instalar dependencias de Python
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# 6) Copiar el código
COPY app.py .

# 7) Exponer puerto y arrancar
EXPOSE 8000
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8000", "app:app"]

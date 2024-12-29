# Base image
# FROM python:3.10-slim

# # Set work directory
# WORKDIR /usr/src/app

# # Install system dependencies
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*

# # Install pip and upgrade it
# RUN pip install --no-cache-dir --upgrade pip

# # Copy requirements file (optional)
# # COPY requirements.txt .

# # Install Python dependencies (if requirements.txt is provided)
# # RUN pip install --no-cache-dir -r requirements.txt

# # Set permissions for external access
# RUN useradd -m devuser \
#     && chown -R devuser:devuser /usr/src/app
# USER devuser

# # Default command
# CMD ["bash"]



# Use a imagem base do Python
FROM python:3.11-slim

# Configura o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências (se existir)
COPY requirements.txt ./

# Instala o pip e as dependências
RUN pip install --no-cache-dir --upgrade pip \
    && if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi

# Garante permissões para manipular arquivos (como no VS Code)
RUN useradd -m devuser \
    && chown -R devuser:devuser /app

# Configura o contêiner para rodar como o usuário não-root
USER devuser

# Expõe a porta padrão (caso seja necessário para o desenvolvimento)
EXPOSE 8000

# Comando padrão do contêiner (altere conforme necessário)
CMD ["python", "-m", "http.server", "8000"]

# Estágio 1: Builder
FROM python:3.10-bullseye as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix="/install" -r requirements.txt

COPY . .

# Estágio 2: Final
FROM python:3.10-slim-bullseye

WORKDIR /app

# Cria um usuário não-root
RUN useradd --create-home appuser
USER appuser

# Copia as dependências e o código do estágio de builder
COPY --from=builder /install /usr/local
COPY --from=builder /app /app

# Expõe a porta que a aplicação irá escutar
EXPOSE 80

# Comando para iniciar a aplicação
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
from flask import Flask, request, jsonify
from pymongo import MongoClient
import os

app = Flask(__name__)

# Conexão com MongoDB via variável de ambiente
client = MongoClient(os.getenv("MONGO_URI", "mongodb://localhost:27017"))
db = client["devops_db"]
collection = db["usuarios"]

@app.route("/")
def home():
    return jsonify({"message": "API DevOps Júnior rodando!"})

@app.route("/usuario", methods=["POST"])
def criar_usuario():
    dados = request.get_json()
    if not dados or "nome" not in dados or "email" not in dados:
        return jsonify({"erro": "nome e email são obrigatórios"}), 400
    
    resultado = collection.insert_one(dados)
    dados["_id"] = str(resultado.inserted_id)
    return jsonify(dados), 201

@app.route("/usuarios", methods=["GET"])
def listar_usuarios():
    usuarios = list(collection.find())
    for u in usuarios:
        u["_id"] = str(u["_id"])
    return jsonify(usuarios)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
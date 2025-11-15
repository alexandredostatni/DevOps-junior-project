Projeto Completo: Simulação de Rotina de DevOps Júnior
Rotina realista de um DevOps júnior em um projeto do zero:
Uma API Python com Flask que salva dados em MongoDB, containerizada com Docker, infra provisionada com Terraform no LocalStack (simulando AWS), orquestrada com Kubernetes local (kind), e CI/CD com GitHub Actions.

**Ferramentas usadas:**
- Python (Flask)
- Docker
- Kubernetes (kind)
- Terraform + LocalStack (AWS S3)
- GitHub Actions
- MongoDB

---

## Como rodar localmente

```bash
# 1. Iniciar LocalStack (AWS local)
./scripts/setup-localstack.sh

# 2. Criar cluster Kubernetes
kind create cluster --config infra/kind/kind-config.yaml

# 3. Build e carregar imagem
docker build -t api-devops:latest ./app
kind load docker-image api-devops:latest

# 4. Aplicar manifests
kubectl apply -f kubernetes/mongo/
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

# 5. Testar
curl http://localhost:5000
curl -X POST http://localhost:5000/usuario \

## Estrututura final do Repositório:
devops-junior-project/
│
├── .github/
│   └── workflows/
│       └── ci-cd.yml                     ← Workflow completo (com schema)
│
├── app/
│   ├── main.py                           ← API Flask + PyMongo
│   ├── requirements.txt                  ← Flask, pymongo, gunicorn
│   └── Dockerfile                        ← Build da imagem
│
├── infra/
│   ├── terraform/
│   │   ├── main.tf                       ← Provider + S3 bucket + objeto
│   │   ├── variables.tf                  ← bucket_name
│   │   └── outputs.tf                    ← bucket_url
│   └── kind/
│       └── kind-config.yaml              ← Configuração do cluster kind
│
├── kubernetes/
│   ├── deployment.yaml                   ← Deployment da API
│   ├── service.yaml                      ← Service NodePort (30000 → 5000)
│   └── mongo/
│       ├── mongo-deployment.yaml         ← MongoDB Deployment
│       └── mongo-service.yaml            ← MongoDB Service (ClusterIP)
│
├── scripts/
│   └── setup-localstack.sh               ← Script para iniciar LocalStack + bucket
│
├── docker-compose.yml                    ← Teste local rápido (API + Mongo)
│
├── README.md                             ← Instruções completas
└── .gitignore                            
  -H "Content-Type: application/json" \
  -d '{"nome":"Maria","email":"maria@ex.com"}'

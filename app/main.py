from fastapi import FastAPI
import socket
import os

app = FastAPI(title="DevOps Demo API")

@app.get("/")
def root():
    return {
        "message": "Hello from FastAPI v2",
        "hostname": socket.gethostname(),
        "environment": os.getenv("ENV", "dev")
    }

@app.get("/health")
def health():
    return {"status": "ok"}


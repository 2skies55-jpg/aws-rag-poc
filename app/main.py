from fastapi import FastAPI, UploadFile, File
from pydantic import BaseModel
import shutil
import os

from rag.ingest import extract_text
from rag.chunker import chunk_text
from rag.vector_store import store_chunks
from rag.retrieve import retrieve_chunks
from rag.llm import ask_llm

app = FastAPI(
    title="AWS RAG POC",
    version="1.0.0"
)

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@app.get("/")
def root():
    return {
        "message": "AWS RAG POC is running!"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.post("/upload")
async def upload_pdf(file: UploadFile = File(...)):

    file_path = os.path.join(UPLOAD_DIR, file.filename)

    # Save uploaded PDF locally
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Upload to S3
    upload_file(
        file_path=file_path,
        object_name=file.filename
    )

    # Extract text
    text = extract_text(file_path)

    # Chunk text
    chunks = chunk_text(text)

    # Store embeddings
    store_chunks(file.filename, chunks)

    return {
        "message": "Upload successful",
        "filename": file.filename,
        "stored_in_s3": True,
        "characters": len(text),
        "chunks": len(chunks),
        "stored_in_vector_db": True
    }


class ChatRequest(BaseModel):
    question: str


@app.post("/chat")
def chat(request: ChatRequest):

    results = retrieve_chunks(request.question)

    answer = ask_llm(
        request.question,
        results["documents"]
    )

    return {
        "question": request.question,
        "answer": answer,
        "sources": results["metadata"]
    }

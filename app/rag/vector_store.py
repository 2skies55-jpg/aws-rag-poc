import chromadb
from sentence_transformers import SentenceTransformer

client = chromadb.PersistentClient(path="./chroma_db")

collection = client.get_or_create_collection(
    name="documents"
)

model = SentenceTransformer("all-MiniLM-L6-v2")


def store_chunks(filename, chunks):

    # Delete old chunks for this file
    try:
        collection.delete(
            where={"filename": filename}
        )
    except Exception:
        pass

    embeddings = model.encode(chunks).tolist()

    ids = [
        f"{filename}-{i}"
        for i in range(len(chunks))
    ]

    metadata = [
        {
            "filename": filename,
            "chunk": i
        }
        for i in range(len(chunks))
    ]

    collection.add(
        ids=ids,
        documents=chunks,
        embeddings=embeddings,
        metadatas=metadata
    )
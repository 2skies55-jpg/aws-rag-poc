import chromadb
from sentence_transformers import SentenceTransformer

client = chromadb.PersistentClient(path="./chroma_db")

collection = client.get_or_create_collection(
    name="documents"
)

model = SentenceTransformer("all-MiniLM-L6-v2")


def retrieve_chunks(question, top_k=3):

    embedding = model.encode(question).tolist()

    results = collection.query(
        query_embeddings=[embedding],
        n_results=top_k
    )

    return {
        "documents": results["documents"][0],
        "metadata": results["metadatas"][0]
    }
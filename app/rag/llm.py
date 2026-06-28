from ollama import chat


def ask_llm(question, chunks):

    context = "\n\n".join(chunks)

    prompt = f"""
You are a helpful assistant.

Answer ONLY using the context below.

If the answer is not present, say:
"I couldn't find that information."

Context:
{context}

Question:
{question}

Answer:
"""

    response = chat(
        model="llama3.2:3b",
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ]
    )

    return response["message"]["content"]
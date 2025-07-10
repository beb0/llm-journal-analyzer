# Dockerfile
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip install \
    fastapi \
    uvicorn \
    torch \
    transformers \
    llama-cpp-python \
    langchain \
    pydantic \
    nltk \
    rake-nltk \
    gdown \
    nest_asyncio \
    langchain-community \
    langchain-core

# Download NLTK data
RUN python -m nltk.downloader punkt stopwords

# Expose port
EXPOSE 8000

# Run app
CMD ["uvicorn", "model:app", "--host", "0.0.0.0", "--port", "8000"]

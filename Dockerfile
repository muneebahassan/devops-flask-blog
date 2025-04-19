# Use official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy requirements and install
COPY app/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire 'app' directory contents into /app
COPY app /app

# Expose port
EXPOSE 5000

# Run the app from the correct location (inside /app)
CMD ["python", "/app/wsgi.py"]  # Specify the full path to wsgi.py


#!/bin/bash

# MintSpeak Development Script
# This script starts the development environment

set -e

echo "🚀 Starting MintSpeak development environment..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function to check if a port is in use
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null ; then
        return 0
    else
        return 1
    fi
}

# Function to start services
start_services() {
    print_status "Starting Docker services..."
    
    if command -v docker &> /dev/null; then
        docker-compose up -d redis
        print_success "Redis started"
    else
        print_status "Docker not available, skipping Redis"
    fi
}

# Function to start frontend
start_frontend() {
    print_status "Starting frontend development server..."
    
    if check_port 3000; then
        print_status "Port 3000 is already in use. Frontend may already be running."
    else
        cd frontend
        npm run dev &
        FRONTEND_PID=$!
        cd ..
        print_success "Frontend started on http://localhost:3000"
    fi
}

# Function to start backend
start_backend() {
    print_status "Starting backend development server..."
    
    if check_port 8000; then
        print_status "Port 8000 is already in use. Backend may already be running."
    else
        cd backend
        uv run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 &
        BACKEND_PID=$!
        cd ..
        print_success "Backend started on http://localhost:8000"
        print_success "API docs available at http://localhost:8000/docs"
    fi
}

# Function to show status
show_status() {
    echo ""
    print_success "🎉 Development environment started!"
    echo ""
    echo "Services:"
    echo "  Frontend: http://localhost:3000"
    echo "  Backend:  http://localhost:8000"
    echo "  API Docs: http://localhost:8000/docs"
    echo ""
    echo "Press Ctrl+C to stop all services"
    echo ""
}

# Function to cleanup on exit
cleanup() {
    echo ""
    print_status "Stopping development servers..."
    
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    
    print_success "Development servers stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Main function
main() {
    start_services
    start_frontend
    start_backend
    show_status
    
    # Wait for user to stop
    wait
}

# Run main function
main "$@" 
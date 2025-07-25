#!/bin/bash

# MintSpeak Setup Script
# This script sets up the development environment for the AI Speech Therapist project

set -e

echo "🚀 Setting up MintSpeak development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are installed
check_requirements() {
    print_status "Checking system requirements..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18+"
        exit 1
    fi
    
    # Check Python
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed. Please install Python 3.11+"
        exit 1
    fi
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        print_warning "Docker is not installed. Some features may not work."
    fi
    
    # Check uv
    if ! command -v uv &> /dev/null; then
        print_warning "uv is not installed. Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    
    print_success "System requirements check completed"
}

# Setup environment variables
setup_env() {
    print_status "Setting up environment variables..."
    
    if [ ! -f .env ]; then
        cp .env.example .env
        print_success "Created .env file from template"
        print_warning "Please edit .env file with your configuration"
    else
        print_status ".env file already exists"
    fi
}

# Setup frontend
setup_frontend() {
    print_status "Setting up frontend..."
    
    cd frontend
    
    # Install dependencies
    if [ ! -d "node_modules" ]; then
        print_status "Installing frontend dependencies..."
        npm install
    fi
    
    # Add additional shadcn/ui components if needed
    print_status "Adding essential shadcn/ui components..."
    npx shadcn@latest add button card input textarea select dialog sheet tabs progress badge avatar --yes
    
    cd ..
    print_success "Frontend setup completed"
}

# Setup backend
setup_backend() {
    print_status "Setting up backend..."
    
    cd backend
    
    # Install dependencies
    print_status "Installing backend dependencies..."
    uv sync
    
    cd ..
    print_success "Backend setup completed"
}

# Create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    mkdir -p data/audio data/models data/database
    mkdir -p services/whisper/models services/ollama/models
    
    # Create .gitkeep files
    touch data/audio/.gitkeep
    touch data/models/.gitkeep
    touch data/database/.gitkeep
    touch services/whisper/models/.gitkeep
    touch services/ollama/models/.gitkeep
    
    print_success "Directories created"
}

# Setup Git hooks
setup_git_hooks() {
    print_status "Setting up Git hooks..."
    
    # Create pre-commit hook
    cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "Running pre-commit checks..."

# Frontend checks
cd frontend
npm run lint
npm run type-check
cd ..

# Backend checks
cd backend
uv run ruff check .
uv run mypy .
cd ..

echo "Pre-commit checks passed!"
EOF
    
    chmod +x .git/hooks/pre-commit
    print_success "Git hooks configured"
}

# Main setup function
main() {
    print_status "Starting MintSpeak setup..."
    
    check_requirements
    setup_env
    create_directories
    setup_frontend
    setup_backend
    setup_git_hooks
    
    print_success "🎉 MintSpeak setup completed successfully!"
    echo ""
    echo "Next steps:"
    echo "1. Edit .env file with your configuration"
    echo "2. Run 'docker-compose up -d' to start services"
    echo "3. Run 'npm run dev' in frontend/ to start development server"
    echo "4. Run 'uv run uvicorn app.main:app --reload' in backend/ to start API server"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@" 
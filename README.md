# MintSpeak - AI Speech Therapist

A self-hosted, privacy-first AI-powered speech coaching application built with modern web technologies.

## 🚀 Project Status

**Current Phase:** Phase 2 - Infrastructure & Setup
**Last Updated:** July 25, 2025

## 📋 What's Been Completed

### ✅ Phase 1: Research & Planning
- [x] Comprehensive research on AI-powered speech therapy
- [x] Tech stack decision (Next.js + FastAPI + whisper.cpp + hybrid LLM)
- [x] Detailed architecture and API specifications
- [x] Database schema design

### ✅ Phase 2.1: Project Structure Setup
- [x] Project directory structure created
- [x] Backend initialized with `uv` (Python 3.11)
- [x] Frontend initialized with Next.js 15 (TypeScript, Tailwind CSS, App Router)
- [x] shadcn/ui components installed and configured
- [x] Modern UI dependencies added (lucide-react, etc.)

## 🏗️ Project Structure

```
MintSpeak/
├── frontend/              # Next.js application (shadcn/ui)
├── backend/               # FastAPI application (uv)
├── services/              # Docker services
│   ├── whisper/           # whisper.cpp container
│   ├── ollama/            # Ollama container
│   └── redis/             # Redis container
├── data/                  # Persistent data
│   ├── audio/             # Audio files
│   ├── models/            # AI model files
│   └── database/          # SQLite database
├── scripts/               # Development scripts
├── docker-compose.yml     # Development environment
├── docker-compose.prod.yml # Production environment
├── .env.example          # Environment variables template
└── README.md             # This file
```

## 🛠️ Tech Stack

- **Frontend:** Next.js 15, TypeScript, Tailwind CSS, shadcn/ui
- **Backend:** FastAPI (Python 3.11), uv package manager
- **AI Services:** whisper.cpp, Ollama, OpenAI API
- **Database:** SQLite
- **Cache:** Redis
- **Deployment:** Docker Compose

## 🎯 Next Steps

### Phase 2.2: Backend Setup
- [ ] Add FastAPI dependencies to backend
- [ ] Set up basic FastAPI application structure
- [ ] Configure database models and connections
- [ ] Implement basic API endpoints

### Phase 2.3: Docker Environment
- [ ] Create Dockerfiles for all services
- [ ] Set up docker-compose.yml
- [ ] Configure whisper.cpp and Ollama containers
- [ ] Test local development environment

## 🚀 Quick Start (Coming Soon)

```bash
# Clone the repository
git clone <repository-url>
cd MintSpeak

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration

# Start development environment
docker-compose up -d

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

## 📚 Documentation

- [AI Speech Therapist Project Document](./AI_Speech_Therapist_Project_Document.md) - Complete project documentation
- [Research Findings](./Research.txt) - Comprehensive research on AI speech therapy

## 🤝 Contributing

This is a personal project by Yashman, built with AI assistance. The focus is on creating a high-quality, privacy-first speech coaching application.

## 📄 License

Personal project - not for public distribution.

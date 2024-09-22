# 📚 Full Stack CRUD Application with Apollo Server, Express, MongoDB, and Flutter 🚀

This project is a full-stack application comprising a Node.js backend (Apollo Server, Express, MongoDB) and a Flutter frontend. The backend handles CRUD operations using GraphQL and MongoDB, and can be deployed to Vercel for production. The Flutter app serves as the frontend that interacts with this backend and can connect to either a local or deployed instance.

---

## 🚀 Features

- 🛠️ **Apollo Server** for handling GraphQL API requests
- 💾 **MongoDB** for data storage with full CRUD (Create, Read, Update, Delete) operations
- ⚙️ **TypeScript** for strong typing in the backend
- 🌐 **Express.js** for server routing and setup
- 📱 **Flutter** integration for mobile front-end interaction
- 🔄 **Vercel** deployment for easy cloud hosting

---

## 📋 Prerequisites

Before starting, ensure you have the following installed:

- 🟢 **Node.js** (version 16 or above)
- 📦 **npm** (comes with Node.js)
- 🗄️ **MongoDB** (either locally or via MongoDB Atlas)
- 🟢 **Flutter SDK** (for the mobile app)
- 🌍 **Vercel CLI** (for deployment)

---

## Getting Started

### 1️⃣ Clone the repository:

```bash
git clone https://github.com/muhammadsobananjum/flutter-graphql-demo
cd books-apollo-server
```

### 2️⃣ Install dependencies:
```bash
npm install
```

### 3️⃣ Set up environment variables 🌱
Create a .env file in the root directory of your Node.js project to store all your environment variables, like MongoDB connection strings and port numbers.

Example:
DATABASE_URL=mongodb://localhost:27017/mydatabase
This file allows you to securely manage environment variables and keeps sensitive data like your database connection string hidden. Add the .env file to your .gitignore to ensure it doesn't get committed.

### 4️⃣ Compile TypeScript 🛠️
This project uses TypeScript, so you'll need to compile the TypeScript code into JavaScript before running it.
```bash
npm run build
```
The compiled JavaScript files will be placed in the dist directory.

###  5️⃣ Running the Backend Server Locally
You can run the server in either development mode or production mode:

### 🔄 Development Mode:
In this mode, nodemon will automatically restart the server when any file changes.
```bash
npm run dev
```
### ✅ Production Mode:
This will run the compiled JavaScript code from the dist directory.
```bash
npm start
```
The server will now be running at http://localhost:4000/ 🌐.

# 🏗️ CRUD Operations with GraphQL

This backend supports basic CRUD operations through GraphQL. You can interact with the API using queries and mutations for creating, reading, updating, and deleting books (or other entities you define).

Once the server is running, you can test the API using the GraphQL Playground:

[http://localhost:4000/graphql](http://localhost:4000/graphql)

## 🌍 Deploying the Backend to Vercel

### 1️⃣ **Install Vercel CLI:**
```bash
npm install -g vercel
```

### 2️⃣ Login to Vercel:
```bash
vercel login
```

### 3️⃣ Deploy:
```bash
vercel
```

Follow the prompts, and Vercel will automatically detect the TypeScript project, build it, and deploy it. You'll get a URL to access your GraphQL API in production!

# 📱 Flutter Frontend Setup

The backend is designed to be consumed by a Flutter app, and this repo can easily be linked with a Flutter project.

## 1️⃣ Set up Environment Variables for Flutter

In your Flutter project, create two environment files:

- **`.env`** (for your production URL)
- **`.env_debug`** (for your local development URL)

Add the backend URLs to these files.

### `.env` (for the deployed backend):
```plaintext
GRAPHQL_API_URL=https://your-deployment-url.vercel.app/graphql
```
.env_debug (for local development):

### `.env_debug` (for the local backend):
```plaintext
GRAPHQL_API_URL=http://localhost:4000/graphql
```
This way, you can easily switch between local and deployed environments by choosing the appropriate .env file.

## 2️⃣ Modify Flutter Code to Use Environment Variables

Add the following code to manage environment variables in your Flutter project:

```dart
import 'app_env_fields.dart';
import 'debug_env.dart';
import 'release_env.dart';

abstract interface class AppEnv implements AppEnvFields {
  static const kDebugMode = false; 
  // false : To run on debug URL
  // true : To run on production URL

  factory AppEnv() => _instance;

  static final AppEnv _instance = kDebugMode ? DebugEnv() : ReleaseEnv();
}
```

Make sure to include the .env files in your Flutter project's .gitignore to prevent exposing your environment variables publicly.

## 3️⃣ Run the Flutter App

To run the Flutter app with the local/deployed backend, use the following command:

```bash
flutter run
```

## 🌟 Features of the Flutter Frontend

The Flutter app allows users to interact with the backend, performing the following CRUD operations:

📘 **Create:** Add new books (or entities)  
🔍 **Read:** Fetch and view a list of books  
🖊️ **Update:** Edit existing books  
🗑️ **Delete:** Remove books from the database  

The app dynamically loads the backend URL based on whether you're in a local development environment or a production environment.

## 📝 Conclusion

You now have a full-stack project with a Node.js backend using Apollo Server and MongoDB, connected to a Flutter frontend. You can run everything locally or deploy the backend to Vercel and integrate it with your Flutter app.

Feel free to extend the functionality and adapt it to your needs! If you have any issues or questions, don’t hesitate to open an issue or contact me.

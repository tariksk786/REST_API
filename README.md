🚀 InternHub API — REST API & Persistent Data

A RESTful API built using Node.js, Express.js, and SQLite for managing internship opportunities with persistent database storage, CRUD operations, input validation, pagination, and structured JSON responses.

This project demonstrates backend development fundamentals, REST API design, database integration, and safe data management.

📌 Project Overview

InternHub API provides a backend system for storing, retrieving, updating, and deleting internship records.

The application uses Express.js to handle HTTP requests and SQLite to store data persistently. It supports searching, filtering, pagination, input validation, and error handling.

🎯 Objectives

- Design and implement RESTful API endpoints.
- Perform Create, Read, Update, and Delete (CRUD) operations.
- Store internship records using SQLite.
- Validate incoming requests.
- Implement pagination and filtering.
- Return consistent HTTP status codes and JSON responses.
- Provide reusable API endpoints for frontend integration.

🛠️ Technology Stack

Technology| Purpose
Node.js| JavaScript runtime
Express.js| Backend web framework
SQLite| Persistent relational database
better-sqlite3| SQLite database driver
JavaScript| Application logic
dotenv| Environment configuration
Postman / curl| API testing

✨ Key Features

- RESTful API architecture.
- Complete CRUD operations.
- Persistent SQLite database.
- Input validation and error handling.
- Search internships by title or company.
- Filter internships by domain.
- Paginated internship listings.
- Consistent JSON API responses.
- Seed data for testing.
- Modular and maintainable project structure.

📁 Project Structure

internhub-api/
├── src/
│   ├── server.js
│   ├── app.js
│   ├── db/
│   │   ├── database.js
│   │   └── seed.js
│   ├── routes/
│   │   └── internshipRoutes.js
│   ├── controllers/
│   │   └── internshipController.js
│   └── middleware/
│       ├── validateInternship.js
│       └── errorHandler.js
├── schema.sql
├── package.json
├── .env.example
├── .gitignore
└── README.md

⚙️ Installation and Setup

1. Clone the Repository

git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY

Replace the placeholders with your actual GitHub username and repository name.

2. Install Dependencies

Make sure Node.js and npm are installed.

npm install

3. Configure Environment Variables

Create a ".env" file in the root directory:

PORT=5000
NODE_ENV=development
DATABASE_PATH=./data/internhub.db

4. Initialize and Seed Database

npm run seed

This command should initialize the SQLite database and populate it with sample internship records.

5. Start the Server

npm start

For development, if configured:

npm run dev

Default local API URL:

"http://localhost:5000"

🗄️ Database Schema

The API uses SQLite to store internship records.

Internships Table

Field| Data Type| Description
id| INTEGER| Primary key
title| TEXT| Internship title
company| TEXT| Company name
domain| TEXT| Internship category
location| TEXT| Internship location
work_mode| TEXT| Remote, Hybrid, On-site
duration| TEXT| Internship duration
stipend| INTEGER| Stipend amount
description| TEXT| Internship details
skills| TEXT| JSON array of required skills
apply_url| TEXT| Application URL
created_at| TEXT| Creation timestamp
updated_at| TEXT| Last update timestamp

SQL Schema Example

CREATE TABLE IF NOT EXISTS internships (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    company TEXT NOT NULL,
    domain TEXT NOT NULL,
    location TEXT NOT NULL,
    work_mode TEXT NOT NULL
        CHECK (work_mode IN ('Remote', 'Hybrid', 'On-site')),
    duration TEXT NOT NULL,
    stipend INTEGER NOT NULL DEFAULT 0
        CHECK (stipend >= 0),
    description TEXT NOT NULL,
    skills TEXT NOT NULL DEFAULT '[]',
    apply_url TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

🌱 Seed Data

The project is designed to support sample internship records across different domains.

Example seed records:

ID| Internship| Company| Domain| Location
1| Frontend Developer Intern| TechNova| Web Development| Pune
2| Data Science Intern| DataSphere| Data Science| Bengaluru
3| AI Research Intern| NeuralWorks| Artificial Intelligence| Hyderabad
4| Cybersecurity Intern| SecureNet| Cybersecurity| Mumbai
5| UI/UX Design Intern| PixelCraft| UI/UX Design| Remote

Seed data is intended for development and demonstration purposes.

To populate the database:

npm run seed

🌐 REST API Endpoints

Base URL:

"http://localhost:5000/api"

Method| Endpoint| Description
GET| "/internships"| Get all internships
GET| "/internships/:id"| Get internship by ID
POST| "/internships"| Create a new internship
PUT| "/internships/:id"| Update internship
DELETE| "/internships/:id"| Delete internship
GET| "/health"| Check API health

📡 API Request and Response Examples

1. GET — Retrieve Internships

Request

GET /api/internships

Example Response — 200 OK

{
  "success": true,
  "data": [
    {
      "id": 1,
      "title": "Frontend Developer Intern",
      "company": "TechNova",
      "domain": "Web Development",
      "location": "Pune",
      "work_mode": "Remote",
      "duration": "3 Months",
      "stipend": 10000,
      "skills": ["HTML", "CSS", "JavaScript"]
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 1,
    "totalPages": 1
  }
}

2. GET — Retrieve Internship by ID

GET /api/internships/1

Returns the internship record with ID 1.

3. POST — Create Internship

Request

POST /api/internships
Content-Type: application/json

Request Body

{
  "title": "Backend Developer Intern",
  "company": "CodeSphere",
  "domain": "Web Development",
  "location": "Remote",
  "work_mode": "Remote",
  "duration": "6 Months",
  "stipend": 15000,
  "description": "Develop and maintain REST APIs.",
  "skills": ["Node.js", "Express.js", "SQL"],
  "apply_url": "https://example.com/apply"
}

Expected Response: "201 Created"

4. PUT — Update Internship

PUT /api/internships/1
Content-Type: application/json

Request Body

{
  "title": "Senior Web Development Intern",
  "company": "TechNova",
  "domain": "Web Development",
  "location": "Pune",
  "work_mode": "Hybrid",
  "duration": "6 Months",
  "stipend": 18000,
  "description": "Develop responsive web applications.",
  "skills": ["HTML", "CSS", "JavaScript"],
  "apply_url": "https://example.com/apply"
}

Expected Response: "200 OK"

5. DELETE — Remove Internship

DELETE /api/internships/1

Expected Response: "204 No Content"

6. Pagination Example

GET /api/internships?page=1&limit=5

Returns the first five internship records along with pagination metadata.

7. Domain Filter Example

GET /api/internships?domain=Cybersecurity

Returns internships matching the selected domain.

8. Search Example

GET /api/internships?search=developer

Returns internships matching the search keyword.

✅ Input Validation

The API should validate incoming internship data to ensure consistency and prevent invalid records.

Validation rules include:

- Required fields must not be empty.
- Internship titles and company names must be valid strings.
- Stipend must be a non-negative number.
- Work mode must be Remote, Hybrid, or On-site.
- Skills must be an array of strings.
- Application URLs must be valid when provided.
- Internship IDs must be positive integers.
- Pagination parameters must be valid positive integers.

⚠️ HTTP Status Codes

Status| Meaning
200 OK| Request successful
201 Created| Internship created
204 No Content| Internship deleted
400 Bad Request| Invalid input
404 Not Found| Internship not found
409 Conflict| Conflicting data
500 Internal Server Error| Unexpected server error

Error Response Example

{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid internship data",
    "details": [
      {
        "field": "title",
        "message": "Title is required"
      }
    ]
  }
}

🧪 API Testing

API endpoints can be tested using Postman, Thunder Client, or curl.

Example:

curl http://localhost:5000/api/internships

Run automated tests, if configured:

npm test

Recommended test cases include successful CRUD operations, invalid input, missing records, pagination, and database persistence after server restart.

🔐 Security Practices

The project is designed around basic API security principles:

- Validate input before database operations.
- Use parameterized SQL queries.
- Avoid SQL injection vulnerabilities.
- Return structured errors without exposing internal details.
- Configure environment variables separately.
- Exclude ".env" and database files from Git.
- Apply appropriate HTTP status codes.

Note: Publicly deployed create, update, and delete endpoints require authentication and authorization before production use.

🔗 Frontend Integration

This REST API is designed to integrate with the Responsive Internship Board frontend.

The frontend can retrieve internship data using JavaScript's Fetch API:

async function loadInternships() {
  try {
    const response = await fetch(
      "http://localhost:5000/api/internships"
    );

    if (!response.ok) {
      throw new Error("Failed to fetch internships");
    }

    const result = await response.json();
    console.log(result.data);
  } catch (error) {
    console.error("API Error:", error);
  }
}

loadInternships();

🚀 Future Enhancements

- User authentication and authorization.
- Secure internship application submission.
- PostgreSQL integration.
- Advanced search and filtering.
- Application tracking dashboard.
- Deployment to a cloud hosting platform.

📚 Learning Outcomes

Through this project, I practiced:

- REST API design.
- Express.js routing and middleware.
- SQLite database operations.
- CRUD implementation.
- API validation and error handling.
- Pagination and filtering.
- Backend testing and documentation.
- Persistent data management.

📄 Project Information

Project: REST API and Persistent Data
Application: InternHub API
Category: Backend Development
Technologies: Node.js, Express.js, SQLite, JavaScript
Purpose: Educational and practical backend development project

---

Built as a hands-on project to demonstrate RESTful API development, database persistence, and structured backend architecture.

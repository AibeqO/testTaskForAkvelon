# Implement Web API for entering project data into the database

The project was created in the integrated development environment of Visual Studio 2022 Version 17.1.0.

Project Information:
1. Version .Net Core - 3.1
2. Installed Nuget packages:
    2.1. Microsoft.Asp Net Core.Mvc.Newtonsoft Json
    2.2. Npgsql
3. Database management system: pgAdmin 4
4. Database: PostgreSQL 14.2

What was implemented:
1. Performing CRUD for the "Project" table having the primary key project_id;
2. Performing CRUD for the "Task" table that has a foreign key that references Project.project_id.

Performed a health check via POSTMAN by sending POST/GET/PUT requests.

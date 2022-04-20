using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;
using System.Data;

namespace ProjectManager.Models
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public TaskController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public JsonResult Get()
        {
            string query = @"SELECT * FROM read_task()";

            DataTable table = new DataTable();

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(table);
        }


        [HttpPost]
        public JsonResult Post(Task task)
        {
            string query = @"CALL create_task (@project_id ,@task_name, @task_description, @priority, @status)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@project_id", task.project_id);
                    myCommand.Parameters.AddWithValue("@task_name", task.task_name);
                    myCommand.Parameters.AddWithValue("@task_description", task.task_description);
                    myCommand.Parameters.AddWithValue("@priority", task.priority);
                    myCommand.Parameters.AddWithValue("@status", task.status);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Added succesfull");
        }


        [HttpPut]
        public JsonResult Put(Task task)
        {
            string query = @"CALL update_task_name(@task_id, @task_name)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue(":task_id", task.task_id);
                    myCommand.Parameters.AddWithValue(":task_name", task.task_name);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Update succesfully");
        }


        [HttpDelete("{id}")]
        public JsonResult Delete(int id)
        {
            string query = @"CALL delete_project(@task_id)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue(":task_id", id);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Delete succesfully");
        }
    }
}

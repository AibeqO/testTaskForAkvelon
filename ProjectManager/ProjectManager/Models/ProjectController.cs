using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Npgsql;
using System.Data;

namespace ProjectManager.Models
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public ProjectController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public JsonResult Get()
        {
            string query = @"SELECT * FROM read_project()";

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
        public JsonResult Post(Project project)
        {
            string query = @"CALL create_project (@project_name, @start_date, @completion_date, @priority, @status)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@project_name", project.project_name);
                    myCommand.Parameters.AddWithValue("@start_date", project.start_date);
                    myCommand.Parameters.AddWithValue("@completion_date", project.completion_date);
                    myCommand.Parameters.AddWithValue("@priority", project.priority);
                    myCommand.Parameters.AddWithValue("@status", project.status);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);

                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Added succesfull");
        }


        [HttpPut]
        public JsonResult Put(Project project)
        {
            string query = @"CALL update_project_name(@project_id, @project_name)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue(":project_id", project.project_id);
                    myCommand.Parameters.AddWithValue(":project_name", project.project_name);

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
            string query = @"CALL delete_project(@project_id)";

            string sqlDataSource = _configuration.GetConnectionString("TaskManagerCon");

            DataTable table = new DataTable();

            NpgsqlDataReader myReader;
            using (NpgsqlConnection myCon = new NpgsqlConnection(sqlDataSource))
            {
                myCon.Open();

                using (NpgsqlCommand myCommand = new NpgsqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue(":project_id", id);

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

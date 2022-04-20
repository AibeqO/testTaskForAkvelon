namespace ProjectManager.Models
{
    public class Task
    {
        public int project_id { get; set; }
        public int task_id { get; set; }
        public string task_name { get; set; }
        public string task_description { get; set; }
        public string status { get; set; }
        public int priority { get; set; }
    }
}

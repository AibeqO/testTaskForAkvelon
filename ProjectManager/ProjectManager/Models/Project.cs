namespace ProjectManager.Models
{
    public class Project
    {
        public int project_id { get; set; }
        public string project_name { get; set; }
        public string start_date { get; set; }
        public string completion_date { get; set; }
        public int priority { get; set; }
        public string status { get; set; }
    }
}

using System;

namespace Volta.Web.Batches.Schedules
{
    public class ScheduleModel
    {
        public Guid id { get; set; }
        public string name { get; set; }
        public string file { get; set; }
        public string createdBy { get; set; }
        public DateTime created { get; set; }
    }
}
using System;
using System.Text;
using Volta.Core.Domain;
using Volta.Core.Domain.Batches;
using Volta.Core.Infrastructure.Framework.Data;
using Volta.Core.Infrastructure.Framework.Web.Fubu;

namespace Volta.Web.Batches.Schedules
{
    public class DownloadGetHandler
    {
        private readonly IRepository<ScheduleFile> _schedules;

        public DownloadGetHandler(IRepository<ScheduleFile> schedules)
        {
            _schedules = schedules;
        }

        public DownloadDataModel ExecuteDownload_id(ScheduleModel request)
        {
            var schedule = _schedules.Get(request.id);
            if (schedule == null) throw new NotFoundException("Schedule");
            return new DownloadDataModel(
                Encoding.GetEncoding(1252).GetBytes(schedule.File), 
                schedule.Name + ".sdu", 
                "text/plain; charset=windows-1252");
        }
    }
}
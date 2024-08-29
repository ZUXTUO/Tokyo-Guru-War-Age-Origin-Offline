using System.Collections.Generic;
using Core.Net;
using SUpdate.GStruct;
using SUpdate.Logic;

namespace SUpdate.Interface
{
	public interface IUpdate
	{
		void Close(Client c);

		void Connection(Client c);

		void Error(Client c, int errortype);

		void DeviceError(Client c, string mes, string url);

		void OpVersion(IList<op_data> fileList, int down_count);

		void DownProcess(UpdateGroup ug, Update up);

		void DownFinish(UpdateGroup ug, Update up, int result);

		void DownProcess(Update up);

		void DownFinish(Update up);
	}
}

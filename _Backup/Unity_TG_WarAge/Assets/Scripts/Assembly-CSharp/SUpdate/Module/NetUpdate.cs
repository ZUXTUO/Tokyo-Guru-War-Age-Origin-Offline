using System.Collections.Generic;
using System.IO;
using Core.Net;
using SUpdate.GNet;
using SUpdate.GStruct;
using SUpdate.Logic;

namespace SUpdate.Module
{
	public class NetUpdate : NUpdate
	{
		private UpdateManager instance = UpdateManager.GetInstance();

		public override bool device_error(Client c, MemoryStream m_, string message, string url)
		{
			return instance.DeviceError(c, m_, message, url);
		}

		public override bool op_version(Client c, MemoryStream m, uint ver, uint op_count)
		{
			return instance.OpVersion(c, m, ver, op_count);
		}

		public override bool op_return(Client c, MemoryStream m, IList<op_data> oplst)
		{
			return instance.OpReturn(c, m, oplst);
		}

		public override bool file_start(Client c, MemoryStream m, string md5code, uint file_size, uint fid)
		{
			return instance.FileStart(c, m, md5code, file_size, fid);
		}

		public override bool file_data(Client c, MemoryStream m, uint fid, uint pos, uint size, byte[] data)
		{
			return instance.FileData(c, m, fid, pos, size, data);
		}

		public override bool file_complete(Client c, MemoryStream m, string md5code, uint file_id, int result)
		{
			return instance.FileComplete(c, m, md5code, file_id, result);
		}
	}
}

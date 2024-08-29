using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using Core.Unity;
using zlib;

namespace Core.Resource
{
	public class StreamHandle
	{
		protected Stream m_stream;

		protected StreamWriter m_writer;

		protected StreamReader m_reader;

		public long position
		{
			get
			{
				return m_stream.Position;
			}
		}

		public long length
		{
			get
			{
				return m_stream.Length;
			}
		}

		public Stream stream
		{
			get
			{
				return m_stream;
			}
		}

		public StreamReader streamReader
		{
			get
			{
				return m_reader;
			}
		}

		public StreamWriter streamWriter
		{
			get
			{
				return m_writer;
			}
		}

		public StreamHandle(Stream stream)
		{
			m_stream = stream;
			if (stream.CanWrite)
			{
				m_writer = new StreamWriter(stream);
			}
			if (stream.CanRead)
			{
				m_reader = new StreamReader(stream);
			}
		}

		public virtual int Read(ref bool value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[1];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToBoolean(array, 0);
			}
			return num;
		}

		public virtual int Read(ref byte value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[1];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = array[0];
			}
			return num;
		}

		public virtual int Read(ref short value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[2];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToInt16(array, 0);
			}
			return num;
		}

		public virtual int Read(ref int value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[4];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToInt32(array, 0);
			}
			return num;
		}

		public virtual int Read(ref uint value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[4];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToUInt32(array, 0);
			}
			return num;
		}

		public virtual int Read(ref ulong value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[8];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToUInt64(array, 0);
			}
			return num;
		}

		public virtual int Read(ref float value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			byte[] array = new byte[4];
			int num = m_stream.Read(array, 0, array.Length);
			if (num > 0)
			{
				value = BitConverter.ToSingle(array, 0);
			}
			return num;
		}

		public virtual int Read(ref string value)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			StringBuilder stringBuilder = new StringBuilder();
			int num = -1;
			char c = '\n';
			num = m_stream.ReadByte();
			if (num == -1)
			{
				return 0;
			}
			for (c = (char)num; c != '\n'; c = (char)num)
			{
				stringBuilder.Append(c);
				num = m_stream.ReadByte();
				if (num == -1)
				{
					break;
				}
			}
			value = stringBuilder.ToString();
			return value.Length;
		}

		public virtual int Read(byte[] buffer)
		{
			if (!m_stream.CanRead)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
				return 0;
			}
			return m_stream.Read(buffer, 0, buffer.Length);
		}

		public void ReadLine(ref string value)
		{
			if (!m_stream.CanRead || streamReader == null)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be read"));
			}
			value = streamReader.ReadLine();
		}

		public virtual void Write(bool value)
		{
			if (!m_stream.CanWrite)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
				return;
			}
			byte[] bytes = BitConverter.GetBytes(value);
			m_stream.Write(bytes, 0, bytes.Length);
		}

		public virtual void Write(int value)
		{
			if (!m_stream.CanWrite)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
				return;
			}
			byte[] bytes = BitConverter.GetBytes(value);
			m_stream.Write(bytes, 0, bytes.Length);
		}

		public virtual void Write(float value)
		{
			if (!m_stream.CanWrite)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
				return;
			}
			byte[] bytes = BitConverter.GetBytes(value);
			m_stream.Write(bytes, 0, bytes.Length);
		}

		public virtual void Write(string value)
		{
			if (!m_stream.CanWrite)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
				return;
			}
			string s = value + '\n';
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			m_stream.Write(bytes, 0, bytes.Length);
		}

		public virtual void Write(IntPtr ptr, int size)
		{
			if (!m_stream.CanWrite)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
				return;
			}
			byte[] array = new byte[size];
			Marshal.Copy(ptr, array, 0, size);
			m_stream.Write(array, 0, array.Length);
		}

		public void WriteLine(string value)
		{
			if (!m_stream.CanWrite || streamWriter == null)
			{
				Debug.LogError(string.Format("[StreamHandle Read] error: stream can not be write"));
			}
			else
			{
				streamWriter.WriteLine(value);
			}
		}

		public static void CopyStream(Stream input, Stream output)
		{
			byte[] buffer = new byte[512];
			int count;
			while ((count = input.Read(buffer, 0, 512)) > 0)
			{
				output.Write(buffer, 0, count);
			}
			output.Flush();
		}

		public Stream UnCompressStream()
		{
			MemoryStream memoryStream = new MemoryStream();
			ZOutputStream zOutputStream = new ZOutputStream(memoryStream);
			CopyStream(m_stream, zOutputStream);
			zOutputStream.finish();
			memoryStream.Position = 0L;
			return memoryStream;
		}

		public void Flush()
		{
			m_stream.Flush();
		}

		public void Close()
		{
			m_stream.Close();
		}
	}
}

using System;
using System.IO;

namespace SUpdate.Logic
{
	public class FileHeader
	{
		private short treaty_type;

		private uint file_size;

		private uint original_file_size;

		private uint file_crc;

		private byte compress_type;

		private byte encrypt_type;

		private uint encry_key_length;

		private byte[] encry_key;

		private byte[] md5 = new byte[16];

		public short Treaty_type
		{
			get
			{
				return treaty_type;
			}
			set
			{
				treaty_type = value;
			}
		}

		public uint File_size
		{
			get
			{
				return file_size;
			}
			set
			{
				file_size = value;
			}
		}

		public uint Original_file_size
		{
			get
			{
				return original_file_size;
			}
			set
			{
				original_file_size = value;
			}
		}

		public uint File_crc
		{
			get
			{
				return file_crc;
			}
			set
			{
				file_crc = value;
			}
		}

		public byte Compress_type
		{
			get
			{
				return compress_type;
			}
			set
			{
				compress_type = value;
			}
		}

		public byte Encrypt_type
		{
			get
			{
				return encrypt_type;
			}
			set
			{
				encrypt_type = value;
			}
		}

		public uint Encry_key_length
		{
			get
			{
				return encry_key_length;
			}
			set
			{
				encry_key_length = value;
			}
		}

		public byte[] Encry_key
		{
			get
			{
				return encry_key;
			}
			set
			{
				encry_key = value;
			}
		}

		public byte[] Md5
		{
			get
			{
				return md5;
			}
			set
			{
				md5 = value;
			}
		}

		public bool Serial(Stream ms)
		{
			if (ms != null && ms.Length >= 36)
			{
				byte[] bytes = BitConverter.GetBytes(treaty_type);
				ms.Write(bytes, 0, bytes.Length);
				byte[] bytes2 = BitConverter.GetBytes(file_size);
				ms.Write(bytes2, 0, bytes2.Length);
				byte[] bytes3 = BitConverter.GetBytes(original_file_size);
				ms.Write(bytes2, 0, bytes3.Length);
				byte[] bytes4 = BitConverter.GetBytes(file_crc);
				ms.Write(bytes4, 0, bytes4.Length);
				ms.WriteByte(compress_type);
				ms.WriteByte(encrypt_type);
				if (encry_key == null)
				{
					encry_key_length = 0u;
				}
				else
				{
					encry_key_length = (uint)encry_key.Length;
				}
				byte[] bytes5 = BitConverter.GetBytes(encry_key_length);
				ms.Write(bytes5, 0, bytes5.Length);
				if (encry_key != null)
				{
					ms.Write(encry_key, 0, encry_key.Length);
				}
				ms.Write(md5, 0, md5.Length);
				return true;
			}
			return false;
		}

		public bool Unserial(Stream ms)
		{
			if (ms != null)
			{
				byte[] array = new byte[2];
				ms.Read(array, 0, 2);
				treaty_type = BitConverter.ToInt16(array, 0);
				byte[] array2 = new byte[4];
				ms.Read(array2, 0, 4);
				file_size = BitConverter.ToUInt32(array2, 0);
				byte[] array3 = new byte[4];
				ms.Read(array3, 0, 4);
				original_file_size = BitConverter.ToUInt32(array3, 0);
				byte[] array4 = new byte[4];
				ms.Read(array4, 0, 4);
				file_crc = BitConverter.ToUInt32(array4, 0);
				byte[] array5 = new byte[2];
				ms.Read(array5, 0, 2);
				compress_type = array5[0];
				encrypt_type = array5[1];
				byte[] array6 = new byte[4];
				ms.Read(array6, 0, 4);
				encry_key_length = BitConverter.ToUInt32(array6, 0);
				if (encry_key_length != 0)
				{
					encry_key = new byte[encry_key_length];
					ms.Read(encry_key, 0, (int)encry_key_length);
				}
				ms.Read(md5, 0, 16);
				return true;
			}
			return false;
		}
	}
}

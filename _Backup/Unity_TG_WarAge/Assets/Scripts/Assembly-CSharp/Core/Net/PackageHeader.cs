using System;

namespace Core.Net
{
	public class PackageHeader
	{
		public static int ByteSize = 8;

		private int length = 8;

		private int messageId;

		public int Length
		{
			get
			{
				return length - Size();
			}
			set
			{
				length = value + Size();
			}
		}

		public int MessageId
		{
			get
			{
				return messageId;
			}
			set
			{
				messageId = value;
			}
		}

		public PackageHeader()
		{
			messageId = 0;
			length = Size();
		}

		public virtual int Size()
		{
			return ByteSize;
		}

		public virtual bool CheckSeqNum(uint inSeqNum)
		{
			return true;
		}

		public virtual uint GetSeqNum()
		{
			return 0u;
		}

		public virtual uint GetCrcCheck()
		{
			return 0u;
		}

		public virtual byte GetCompressType()
		{
			return 0;
		}

		public virtual uint GetSourceLength()
		{
			return 0u;
		}

		public virtual bool SetSeqNum(uint inSeq)
		{
			return true;
		}

		public virtual bool SetCrcCheck(uint inCrcCheck)
		{
			return true;
		}

		public virtual bool SetCrcCheck2(uint inCrcCheck)
		{
			return true;
		}

		public virtual bool SetCompressType(byte inType)
		{
			return true;
		}

		public virtual bool SetSourceLength(uint inLength)
		{
			return true;
		}

		public virtual bool SetExtData(uint data)
		{
			return true;
		}

		public virtual uint GetExtData()
		{
			return 0u;
		}

		public virtual bool Serial(byte[] dest, int offset)
		{
			if (dest.Length >= Size())
			{
				byte[] bytes = BitConverter.GetBytes(messageId);
				byte[] bytes2 = BitConverter.GetBytes(length);
				Array.Copy(bytes, 0, dest, offset, 4);
				Array.Copy(bytes2, 0, dest, offset + 4, 4);
				return true;
			}
			return false;
		}

		public virtual bool Unserial(byte[] dest, int offset)
		{
			if (dest.Length >= Size())
			{
				messageId = BitConverter.ToInt32(dest, offset);
				length = BitConverter.ToInt32(dest, 4 + offset);
				return true;
			}
			return false;
		}
	}
}

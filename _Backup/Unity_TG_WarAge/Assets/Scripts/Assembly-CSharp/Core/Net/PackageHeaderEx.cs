using System;

namespace Core.Net
{
	public class PackageHeaderEx : PackageHeader
	{
		private uint seq_num_;

		private uint crc_check_;

		private byte compress_type_;

		private uint source_length_;

		private uint ext_data_;

		public uint crc_check_2_;

		public new static int ByteSize = PackageHeader.ByteSize + 4 + 4 + 1 + 4 + 4 + 4;

		public override bool Serial(byte[] dest, int offset)
		{
			if (dest.Length >= Size() && base.Serial(dest, offset))
			{
				offset += base.Size();
				byte[] bytes = BitConverter.GetBytes(seq_num_);
				byte[] bytes2 = BitConverter.GetBytes(crc_check_);
				byte b = compress_type_;
				byte[] bytes3 = BitConverter.GetBytes(source_length_);
				byte[] bytes4 = BitConverter.GetBytes(ext_data_);
				byte[] bytes5 = BitConverter.GetBytes(crc_check_2_);
				Array.Copy(bytes, 0, dest, offset, 4);
				Array.Copy(bytes2, 0, dest, offset + 4, 4);
				dest[offset + 8] = b;
				Array.Copy(bytes3, 0, dest, offset + 9, 4);
				Array.Copy(bytes4, 0, dest, offset + 13, 4);
				Array.Copy(bytes5, 0, dest, offset + 17, 4);
				return true;
			}
			return false;
		}

		public override bool Unserial(byte[] dest, int offset)
		{
			if (dest.Length >= Size() && base.Unserial(dest, offset))
			{
				offset += base.Size();
				seq_num_ = BitConverter.ToUInt32(dest, offset);
				crc_check_ = BitConverter.ToUInt32(dest, offset + 4);
				compress_type_ = dest[offset + 8];
				source_length_ = BitConverter.ToUInt32(dest, offset + 9);
				ext_data_ = BitConverter.ToUInt32(dest, offset + 13);
				crc_check_2_ = BitConverter.ToUInt32(dest, offset + 17);
				return true;
			}
			return false;
		}

		public override int Size()
		{
			return ByteSize;
		}

		public override bool CheckSeqNum(uint inSeqNum)
		{
			return seq_num_ == inSeqNum;
		}

		public override uint GetSeqNum()
		{
			return seq_num_;
		}

		public override uint GetCrcCheck()
		{
			return crc_check_;
		}

		public override byte GetCompressType()
		{
			return compress_type_;
		}

		public override uint GetSourceLength()
		{
			return source_length_;
		}

		public override bool SetSeqNum(uint inSeq)
		{
			seq_num_ = inSeq;
			return true;
		}

		public override bool SetCrcCheck(uint inCrcCheck)
		{
			crc_check_ = inCrcCheck;
			return true;
		}

		public override bool SetCrcCheck2(uint inCrcCheck)
		{
			crc_check_2_ = inCrcCheck;
			return true;
		}

		public override bool SetCompressType(byte inType)
		{
			compress_type_ = inType;
			return true;
		}

		public override bool SetSourceLength(uint inLength)
		{
			source_length_ = inLength;
			return true;
		}

		public override bool SetExtData(uint data)
		{
			ext_data_ = data;
			return true;
		}

		public override uint GetExtData()
		{
			return ext_data_;
		}
	}
}

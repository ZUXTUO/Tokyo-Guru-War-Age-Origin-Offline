namespace YunvaIM
{
	public class InvokeEventClass
	{
		public ProtocolEnum eventType;

		public object dataObj;

		public InvokeEventClass(ProtocolEnum EventType, object DataObj)
		{
			eventType = EventType;
			dataObj = DataObj;
		}
	}
}

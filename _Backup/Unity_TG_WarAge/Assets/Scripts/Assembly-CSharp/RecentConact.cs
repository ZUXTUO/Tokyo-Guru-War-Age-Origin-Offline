public class RecentConact
{
	public int endId;

	public int unread;

	public P2PChatMsg lastMsg;

	public NearChatInfo userInfo;

	public RecentConact()
	{
		if (lastMsg == null)
		{
			lastMsg = new P2PChatMsg();
		}
		if (userInfo == null)
		{
			userInfo = new NearChatInfo();
		}
	}
}

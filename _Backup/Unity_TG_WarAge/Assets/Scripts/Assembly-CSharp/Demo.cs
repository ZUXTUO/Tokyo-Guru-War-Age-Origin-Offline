using System;
using UnityEngine;
using YunvaIM;

public class Demo : MonoBehaviour
{
	private string labelText = "ssss";

	private string addWildCard = string.Empty;

	private string sTestMsg = "请输入文本消息";

	private string sMsgChannelNotify = "接收频道消息\n";

	private string sMsgP2PNotify = "接收私聊消息\n";

	private string sUserId = "请输入用户id";

	private string strfilepath = string.Empty;

	private string recordUrlPath = string.Empty;

	private uint time;

	public GUISkin guiSkin;

	private void Start()
	{
		EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_MESSAGE_NOTIFY, OnChannelMessageNotify);
		EventListenerManager.AddListener(ProtocolEnum.IM_CHAT_FRIEND_NOTIFY, OnP2PMessageNotify);
		EventListenerManager.AddListener(ProtocolEnum.IM_CHANNEL_PUSH_MSG_NOTIFY, OnChannelMsgPushNotify);
		EventListenerManager.AddListener(ProtocolEnum.IM_CLOUDMSG_LIMIT_NOTIFY, OnCloudMsgLimitNotify);
		EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_VOLUME_NOTIFY, ImRecordVolume);
		EventListenerManager.AddListener(ProtocolEnum.IM_NET_STATE_NOTIFY, NetStateNotify);
		if (MonoSingleton<YunVaImSDK>.instance.YunVa_Init(0u, 100041u, Application.persistentDataPath, false, false) == 0)
		{
			Debug.Log("初始化成功...");
			labelText = "初始化成功...";
		}
		else
		{
			Debug.Log("初始化失败...");
			labelText = "初始化失败...";
		}
	}

	private void OnGUI()
	{
		if (guiSkin != null)
		{
			GUI.skin = guiSkin;
		}
		sTestMsg = GUI.TextField(new Rect(400f, 50f, 300f, 100f), sTestMsg);
		sUserId = GUI.TextField(new Rect(20f, 50f, 150f, 100f), sUserId);
		GUI.Box(new Rect(10f, 10f, 340f, 900f), "菜单");
		if (GUI.Button(new Rect(20f, 150f, 150f, 100f), "登录"))
		{
			string format = "{{\"nickname\":\"{0}\",\"uid\":\"{1}\"}}";
			string tt = string.Format(format, sUserId, sUserId);
			string[] wildCard = new string[2] { "0x001", "0x002" };
			MonoSingleton<YunVaImSDK>.instance.YunVaOnLogin(tt, "100abc", wildCard, 0, delegate(ImThirdLoginResp data)
			{
				if (data.result == 0)
				{
					MonoSingleton<YunVaImSDK>.instance.RecordSetInfoReq(true);
					labelText = string.Format("账号登录成功，昵称:{0},用户ID:{1}", data.nickName, data.userId);
					Debug.Log(labelText);
				}
				else
				{
					labelText = string.Format("账号登录失败，错误消息：{0}", data.msg);
					Debug.Log(labelText);
				}
			}, delegate(ImChannelLoginResp data1)
			{
				if (data1.result == 0)
				{
					labelText = string.Format("频道登录成功...");
					Debug.Log(string.Format("频道登录成功..."));
				}
				else
				{
					labelText = string.Format("频道登录失败...") + data1.msg;
					Debug.Log(string.Format("频道登录失败...") + data1.msg);
				}
			});
		}
		if (GUI.Button(new Rect(20f, 250f, 150f, 100f), "登陆频道"))
		{
			MonoSingleton<YunVaImSDK>.instance.LoginChannel(2, "EN_Andy", delegate(ImChannelMotifyResp data1)
			{
				if (data1.result == 0)
				{
					addWildCard = string.Empty;
					for (int k = 0; k < data1.wildcard.Count; k++)
					{
						addWildCard = addWildCard + data1.wildcard[k] + ",";
					}
					labelText = "登陆频道后该用户登录的频道集合：" + addWildCard;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "登陆频道失败";
					Debug.Log(labelText);
				}
			});
		}
		if (GUI.Button(new Rect(20f, 350f, 150f, 100f), "退出频道"))
		{
			MonoSingleton<YunVaImSDK>.instance.LogoutChannel(2, "EN_Andy", delegate(ImChannelMotifyResp data2)
			{
				if (data2.result == 0)
				{
					addWildCard = string.Empty;
					for (int j = 0; j < data2.wildcard.Count; j++)
					{
						addWildCard = addWildCard + data2.wildcard[j] + ",";
					}
					labelText = "退出频道后该用户登录的频道集合：" + addWildCard;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "退出频道失败";
					Debug.Log(labelText);
				}
			});
		}
		if (GUI.Button(new Rect(20f, 450f, 150f, 100f), "获取私聊历史消息"))
		{
			MonoSingleton<YunVaImSDK>.instance.cloudMsgRequest("P2P", int.Parse(sTestMsg), 0, -20, delegate(ImCloudMsgLimitResp data2)
			{
				if (data2.results == 0)
				{
					labelText = "请求云消息成功";
					Debug.Log(labelText);
				}
				else
				{
					labelText = "请求云消息失败：" + data2.msgs;
					Debug.Log(labelText);
				}
			});
		}
		if (GUI.Button(new Rect(20f, 550f, 150f, 100f), "获取频道历史消息"))
		{
			MonoSingleton<YunVaImSDK>.instance.getChannelHistoryMsg(0, -15, "0x001", delegate(ImChannelHistoryMsgResp data3)
			{
				labelText = "获取条数：" + data3.channelHisList.Count;
				for (int i = 0; i < data3.channelHisList.Count; i++)
				{
					sMsgChannelNotify = sMsgChannelNotify + "index:" + data3.channelHisList[i].index + ",userId:" + data3.channelHisList[i].userId + ",messageBody:" + data3.channelHisList[i].messageBody + ",messageType:" + data3.channelHisList[i].messageType + ",attach:" + data3.channelHisList[i].attach + ",ctime:" + data3.channelHisList[i].ctime + "\n";
				}
				Debug.Log(labelText);
			});
		}
		if (GUI.Button(new Rect(170f, 50f, 150f, 100f), "上传语音文件"))
		{
			Debug.Log("准备上传：" + strfilepath);
			labelText = "准备上传:" + strfilepath;
			string fileId = DateTime.Now.ToFileTime().ToString();
			MonoSingleton<YunVaImSDK>.instance.UploadFileRequest(strfilepath, fileId, delegate(ImUploadFileResp data1)
			{
				if (data1.result == 0)
				{
					recordUrlPath = data1.fileurl;
					Debug.Log("上传成功:" + recordUrlPath);
					labelText = "上传成功:" + recordUrlPath;
				}
				else
				{
					labelText = "上传失败:" + data1.msg;
					Debug.Log("上传失败:" + data1.msg);
				}
			});
		}
		if (GUI.Button(new Rect(170f, 150f, 150f, 100f), "下载语音文件"))
		{
			labelText = "下载语音......";
			string text = string.Format("{0}/{1}.amr", Application.persistentDataPath, DateTime.Now.ToFileTime());
			Debug.Log("下载语音:" + text);
			string fileid = DateTime.Now.ToFileTime().ToString();
			MonoSingleton<YunVaImSDK>.instance.DownLoadFileRequest(recordUrlPath, text, fileid, delegate(ImDownLoadFileResp data4)
			{
				if (data4.result == 0)
				{
					Debug.Log("下载成功:" + data4.filename);
					labelText = "下载成功:" + data4.filename;
				}
				else
				{
					Debug.Log("下载失败:" + data4.msg);
					labelText = "下载失败:" + data4.msg;
				}
			});
		}
		if (GUI.Button(new Rect(170f, 250f, 150f, 100f), "播放url语音"))
		{
			string ext = DateTime.Now.ToFileTime().ToString();
			MonoSingleton<YunVaImSDK>.instance.RecordStartPlayRequest(string.Empty, recordUrlPath, ext, delegate(ImRecordFinishPlayResp data2)
			{
				if (data2.result == 0)
				{
					Debug.Log("播放成功");
					labelText = "播放成功";
				}
				else
				{
					Debug.Log("播放失败");
					labelText = "播放失败";
				}
			});
		}
		if (GUI.Button(new Rect(170f, 350f, 150f, 100f), "开始录音"))
		{
			labelText = "正在录音...";
			string filePath = string.Format("{0}/{1}.amr", Application.persistentDataPath, DateTime.Now.ToFileTime());
			int num = MonoSingleton<YunVaImSDK>.instance.RecordStartRequest(filePath, 1, string.Empty);
			labelText = "正在录音...ret=" + num;
		}
		if (GUI.Button(new Rect(170f, 450f, 150f, 100f), "结束录音"))
		{
			MonoSingleton<YunVaImSDK>.instance.RecordStopRequest(delegate(ImRecordStopResp data)
			{
				if (!string.IsNullOrEmpty(data.strfilepath))
				{
					strfilepath = data.strfilepath;
					time = data.time;
					labelText = "结束录音返回:strfilepath=" + strfilepath + ",time=" + time;
					Debug.Log(labelText);
				}
			}, delegate(ImUploadFileResp data2)
			{
				if (data2.result == 0)
				{
					recordUrlPath = data2.fileurl;
					Debug.Log("上传成功:" + recordUrlPath);
					labelText = "上传成功:" + recordUrlPath;
				}
				else
				{
					labelText = "上传失败:" + data2.result + "," + data2.msg;
					Debug.Log("上传失败:" + data2.result + "," + data2.msg);
				}
			}, delegate(ImSpeechStopResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "识别成功，识别内容:" + data3.text;
					recordUrlPath = data3.url;
				}
				else
				{
					labelText = "识别失败，原因:" + data3.result + "," + data3.msg;
					labelText = "识别失败，原因:" + data3.result + "," + data3.msg;
				}
			});
		}
		if (GUI.Button(new Rect(170f, 550f, 150f, 100f), "播放本地录音"))
		{
			string ext2 = DateTime.Now.ToFileTime().ToString();
			MonoSingleton<YunVaImSDK>.instance.RecordStartPlayRequest(strfilepath, string.Empty, ext2, delegate(ImRecordFinishPlayResp data2)
			{
				if (data2.result == 0)
				{
					Debug.Log("播放成功");
					labelText = "播放成功";
				}
				else
				{
					Debug.Log("播放失败");
					labelText = "播放失败";
				}
			});
		}
		if (GUI.Button(new Rect(400f, 400f, 150f, 100f), "语音识别"))
		{
			labelText = "语音识别.........";
			Debug.Log("语音识别");
			string ext3 = DateTime.Now.ToFileTime().ToString();
			MonoSingleton<YunVaImSDK>.instance.SpeechStartRequest(strfilepath, ext3, delegate(ImSpeechStopResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "识别成功，识别内容:" + data3.text;
					recordUrlPath = data3.url;
				}
				else
				{
					labelText = "识别失败，原因:" + data3.msg;
				}
			}, 1, string.Empty);
		}
		if (GUI.Button(new Rect(400f, 150f, 150f, 100f), "发送频道文本"))
		{
			int num2 = MonoSingleton<YunVaImSDK>.instance.SendChannelTextMessage(sTestMsg, "0x001", delegate(ImChannelSendMsgResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "发送成功,expand:" + data3.expand + ",flag:" + data3.flag;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "发送失败";
					Debug.Log(labelText);
				}
			}, "is ext", "is flag");
			Debug.Log("return_SendChannelTextMessage=" + num2);
		}
		if (GUI.Button(new Rect(550f, 150f, 150f, 100f), "发送频道语音"))
		{
			int num3 = MonoSingleton<YunVaImSDK>.instance.SendChannelVoiceMessage(strfilepath, int.Parse(time.ToString()), "0x001", "语音识别出的文本用此字段传给对方", delegate(ImChannelSendMsgResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "发送成功,expand:" + data3.expand + ",flag:" + data3.flag;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "发送失败";
					Debug.Log(labelText);
				}
			}, "is ext", "is flag");
			Debug.Log("return_SendChannelVoiceMessage=" + num3);
		}
		if (GUI.Button(new Rect(700f, 150f, 150f, 100f), "发送私聊文本"))
		{
			MonoSingleton<YunVaImSDK>.instance.SendP2PTextMessage(sUserId, sTestMsg, delegate(ImChatFriendResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "发送成功,userId:" + data3.userId + ",flag:" + data3.flag;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "发送失败";
					Debug.Log(labelText);
				}
			}, "is flag", "is ext");
		}
		if (GUI.Button(new Rect(850f, 150f, 150f, 100f), "发送私聊语音"))
		{
			MonoSingleton<YunVaImSDK>.instance.SendP2PVoiceMessage(sUserId, strfilepath, int.Parse(time.ToString()), "语音识别出的文本用此字段传给对方", delegate(ImChatFriendResp data3)
			{
				if (data3.result == 0)
				{
					labelText = "发送成功,userId:" + data3.userId + ",flag:" + data3.flag;
					Debug.Log(labelText);
				}
				else
				{
					labelText = "发送失败";
					Debug.Log(labelText);
				}
			}, "is flag", "is ext");
		}
		GUI.Label(new Rect(400f, 10f, 500f, 30f), "返回提示:");
		GUI.Label(new Rect(460f, 10f, 500f, 50f), labelText);
		GUI.Label(new Rect(400f, 300f, 500f, 500f), sMsgChannelNotify);
		GUI.Label(new Rect(800f, 300f, 500f, 500f), sMsgP2PNotify);
	}

	public void OnChannelMessageNotify(object data)
	{
		ImChannelMessageNotify imChannelMessageNotify = data as ImChannelMessageNotify;
		sMsgChannelNotify = "接收频道消息：\nuserId:" + imChannelMessageNotify.userId + "\nmessageBody:" + imChannelMessageNotify.messageBody + "\nnickname:" + imChannelMessageNotify.nickname + "\next1:" + imChannelMessageNotify.ext1 + "\nchannel:" + imChannelMessageNotify.channel + "\nwildcard:" + imChannelMessageNotify.wildcard + "\nmessageType:" + imChannelMessageNotify.messageType + "\nvoiceDuration:" + imChannelMessageNotify.voiceDuration + "\nattach:" + imChannelMessageNotify.attach + "\n";
		Debug.Log(sMsgChannelNotify);
	}

	public void OnP2PMessageNotify(object data)
	{
		Debug.Log("接收到私聊消息...");
		ImChatFriendNotify imChatFriendNotify = data as ImChatFriendNotify;
		sMsgP2PNotify = string.Empty;
		sMsgP2PNotify = "接收私聊消息：\nuserID:" + imChatFriendNotify.chatMsg.userID + "\nname:" + imChatFriendNotify.chatMsg.name + "\nsignature:" + imChatFriendNotify.chatMsg.signature + "\nheadUrl:" + imChatFriendNotify.chatMsg.headUrl + "\nsendTime:" + imChatFriendNotify.chatMsg.sendTime + "\ntype:" + imChatFriendNotify.chatMsg.type + "\ndata:" + imChatFriendNotify.chatMsg.data + "\nimageUrl:" + imChatFriendNotify.chatMsg.imageUrl + "\naudioTime:" + imChatFriendNotify.chatMsg.audioTime + "\nattach:" + imChatFriendNotify.chatMsg.attach + "\next1:" + imChatFriendNotify.chatMsg.ext1 + "\ncloudMsgID:" + imChatFriendNotify.chatMsg.cloudMsgID + "\ncloudResource:" + imChatFriendNotify.chatMsg.cloudResource + "\n";
		Debug.Log(sMsgP2PNotify);
	}

	public void OnCloudMsgLimitNotify(object data)
	{
		ImCloudmsgLimitNotify imCloudmsgLimitNotify = data as ImCloudmsgLimitNotify;
		Debug.Log("获取私聊消息条数：" + imCloudmsgLimitNotify.count);
		for (int i = 0; i < imCloudmsgLimitNotify.pacektList.Count; i++)
		{
			sMsgP2PNotify = sMsgP2PNotify + ",index:" + imCloudmsgLimitNotify.pacektList[i].index + ",userID:" + imCloudmsgLimitNotify.pacektList[i].userID + ",type:" + imCloudmsgLimitNotify.pacektList[i].type + ",data:" + imCloudmsgLimitNotify.pacektList[i].data + ",attach:" + imCloudmsgLimitNotify.pacektList[i].attach + "\n";
		}
		Debug.Log(labelText);
	}

	public void OnChannelMsgPushNotify(object data)
	{
		ImChannelPushMsgNotify imChannelPushMsgNotify = data as ImChannelPushMsgNotify;
		labelText = "type:" + imChannelPushMsgNotify.type + " &&& data:" + imChannelPushMsgNotify.data;
		Debug.Log(labelText);
	}

	public void ImRecordVolume(object data)
	{
		ImRecordVolumeNotify imRecordVolumeNotify = data as ImRecordVolumeNotify;
		Debug.Log("ImRecordVolumeNotify:v_volume=" + imRecordVolumeNotify.v_volume + ",v_ext=" + imRecordVolumeNotify.v_ext);
	}

	public void NetStateNotify(object data)
	{
		ImNetStateNotify imNetStateNotify = data as ImNetStateNotify;
		if (imNetStateNotify.netState == YvNet.YvNetDisconnect)
		{
			sMsgP2PNotify = "网络未连接";
		}
		else
		{
			sMsgP2PNotify = "网络已连接";
		}
		Debug.Log("@ImNetStateNotify@:" + imNetStateNotify.netState);
	}
}

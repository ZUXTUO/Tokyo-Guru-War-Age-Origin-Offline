using System;
using System.Collections.Generic;
using Script;
using UnityEngine;

namespace Core.Timer
{
	public class TimerManager : MonoBehaviourEx
	{
		private static string go_name = "_TimerManager";

		private static TimerManager instance;

		private Dictionary<int, Timer> updateTimers = new Dictionary<int, Timer>();

		private bool processingTimes;

		private LinkedList<int> delayRemoveTimer = new LinkedList<int>();

		private LinkedList<int> needRemoveTimers = new LinkedList<int>();

		private LinkedList<Timer> needAddTimers = new LinkedList<Timer>();

		public static TimerManager GetInstance()
		{
			if (instance == null)
			{
				GameObject gameObject = MonoBehaviourEx.CreateGameObject(go_name);
				instance = gameObject.AddComponent<TimerManager>();
			}
			return instance;
		}

		public int Create(string callback, float interval, int loop, int type, bool bpause)
		{
			if (callback == null || callback.Length == 0)
			{
				return 0;
			}
			if (interval <= 0f || loop == 0)
			{
				return 0;
			}
			if (type != 1 && type != 2 && type != 3)
			{
				return 0;
			}
			Timer timer = new Timer();
			timer.Init(callback, interval, loop);
			timer.type = type;
			timer.pause = bpause;
			if (processingTimes)
			{
				needAddTimers.AddLast(timer);
			}
			else
			{
				updateTimers.Add(timer.GetPid(), timer);
			}
			return timer.GetPid();
		}

		public void Remove(int timerId)
		{
			delayRemoveTimer.AddLast(timerId);
		}

		private Timer GetTimer(int timerid)
		{
			Timer value = null;
			if (!updateTimers.TryGetValue(timerid, out value))
			{
				value = null;
				foreach (Timer needAddTimer in needAddTimers)
				{
					if (needAddTimer.GetPid() == timerid)
					{
						value = needAddTimer;
					}
				}
			}
			return value;
		}

		public void Pause(int timerId, bool pause)
		{
			Timer timer = GetTimer(timerId);
			if (timer != null)
			{
				timer.pause = pause;
			}
		}

		public void Pause(bool pause)
		{
			Dictionary<int, Timer>.Enumerator enumerator = updateTimers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Value.pause = pause;
			}
			foreach (Timer needAddTimer in needAddTimers)
			{
				needAddTimer.pause = pause;
			}
		}

		private void Update()
		{
			LinkedListNode<int> linkedListNode = null;
			if (delayRemoveTimer.Count > 0)
			{
				for (linkedListNode = delayRemoveTimer.First; linkedListNode != delayRemoveTimer.Last; linkedListNode = linkedListNode.Next)
				{
					updateTimers.Remove(linkedListNode.Value);
				}
				updateTimers.Remove(delayRemoveTimer.Last.Value);
				delayRemoveTimer.Clear();
			}
			processingTimes = true;
			if (updateTimers.Count > 0)
			{
				Dictionary<int, Timer>.Enumerator enumerator = updateTimers.GetEnumerator();
				Timer timer = null;
				while (enumerator.MoveNext())
				{
					timer = enumerator.Current.Value;
					if (!timer.pause)
					{
						ProcessTimer(timer);
						if (timer.loop == 0)
						{
							needRemoveTimers.AddLast(enumerator.Current.Key);
						}
					}
				}
			}
			processingTimes = false;
			LinkedListNode<Timer> linkedListNode2 = null;
			if (needAddTimers.Count > 0)
			{
				for (linkedListNode2 = needAddTimers.First; linkedListNode2 != needAddTimers.Last; linkedListNode2 = linkedListNode2.Next)
				{
					updateTimers.Add(linkedListNode2.Value.GetPid(), linkedListNode2.Value);
				}
				updateTimers.Add(needAddTimers.Last.Value.GetPid(), needAddTimers.Last.Value);
				needAddTimers.Clear();
			}
			if (needRemoveTimers.Count > 0)
			{
				for (linkedListNode = needRemoveTimers.First; linkedListNode != needRemoveTimers.Last; linkedListNode = linkedListNode.Next)
				{
					updateTimers.Remove(linkedListNode.Value);
				}
				updateTimers.Remove(needRemoveTimers.Last.Value);
				needRemoveTimers.Clear();
			}
		}

		private void ProcessTimer(Timer t)
		{
			if (t.lastTime + Time.deltaTime >= t.interval)
			{
				float num = t.lastTime + Time.deltaTime;
				if (t.type == 1)
				{
					int num2 = (int)Math.Floor(num / t.interval);
					t.lastTime = num - (float)num2 * t.interval;
					if (t.loop > 0)
					{
						t.loop--;
					}
					CallTimer(t);
				}
				else if (t.type == 2)
				{
					int num3 = (int)Math.Floor(num / t.interval);
					t.lastTime = num - (float)num3 * t.interval;
					if (t.loop > 0)
					{
						t.loop -= ((num3 <= t.loop) ? num3 : t.loop);
					}
					CallTimer(t);
				}
				else
				{
					if (t.type != 3)
					{
						return;
					}
					while (num >= t.interval)
					{
						CallTimer(t);
						num -= t.interval;
						if (t.loop > 0)
						{
							t.loop--;
						}
						if (t.loop == 0)
						{
							break;
						}
					}
					t.lastTime = num;
				}
			}
			else
			{
				t.lastTime += Time.deltaTime;
			}
		}

		private void CallTimer(Timer t)
		{
			ScriptManager.GetInstance().CallFunction(t.callback, t.GetPid());
		}
	}
}

using UnityEngine;

public class MainAnimation : MonoBehaviour
{
	public GameObject ui;

	public float timeScale = 1f;

	private bool init_pos;

	private GameObject contain_di;

	private GameObject[] p_ding_obj = new GameObject[5];

	private UISprite[] p_ding_sprite = new UISprite[5];

	private GameObject[] p_di_obj = new GameObject[5];

	private UISprite[] p_di_sprite = new UISprite[5];

	private void Start()
	{
		contain_di = base.gameObject.transform.Find("contain_di").gameObject;
		for (int i = 0; i <= 4; i++)
		{
			p_ding_obj[i] = base.gameObject.transform.Find("sp_player" + i).gameObject;
			p_ding_sprite[i] = p_ding_obj[i].GetComponent<UISprite>();
			p_di_obj[i] = base.gameObject.transform.Find("contain_di/sp_player" + i + "_di").gameObject;
			p_di_sprite[i] = p_di_obj[i].GetComponent<UISprite>();
		}
	}

	private void Update()
	{
		Time.timeScale = timeScale;
	}

	private void OnAniCallback(string eventName)
	{
		if (eventName == "switch_role")
		{
			p_di_sprite[1].spriteName = p_ding_sprite[2].spriteName;
			p_di_sprite[2].spriteName = p_ding_sprite[3].spriteName;
			p_di_sprite[3].spriteName = p_ding_sprite[1].spriteName;
			contain_di.SetActive(true);
			for (int i = 0; i <= 4; i++)
			{
				p_ding_obj[i].SetActive(false);
			}
			for (int j = 0; j <= 4; j++)
			{
				p_ding_sprite[j].color = p_di_sprite[j].color;
			}
			p_ding_sprite[0].spriteName = p_ding_sprite[1].spriteName;
			p_ding_sprite[1].spriteName = p_ding_sprite[2].spriteName;
			p_ding_sprite[2].spriteName = p_ding_sprite[3].spriteName;
			p_ding_sprite[3].spriteName = p_ding_sprite[0].spriteName;
			p_ding_sprite[4].spriteName = p_ding_sprite[1].spriteName;
		}
		else if (eventName == "switch_role2")
		{
			p_di_sprite[1].spriteName = p_ding_sprite[3].spriteName;
			p_di_sprite[2].spriteName = p_ding_sprite[1].spriteName;
			p_di_sprite[3].spriteName = p_ding_sprite[2].spriteName;
			contain_di.SetActive(true);
			for (int k = 0; k <= 4; k++)
			{
				p_ding_obj[k].SetActive(false);
			}
			for (int l = 0; l <= 4; l++)
			{
				p_ding_sprite[l].color = p_di_sprite[l].color;
			}
			p_ding_sprite[4].spriteName = p_ding_sprite[3].spriteName;
			p_ding_sprite[3].spriteName = p_ding_sprite[2].spriteName;
			p_ding_sprite[2].spriteName = p_ding_sprite[1].spriteName;
			p_ding_sprite[1].spriteName = p_ding_sprite[0].spriteName;
			p_ding_sprite[0].spriteName = p_ding_sprite[3].spriteName;
		}
	}
}

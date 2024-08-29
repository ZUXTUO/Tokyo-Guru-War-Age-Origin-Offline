public class AppConfig
{
	private static int m_fxQualityLevel = 3;

	public static int GetFXQualityLevel()
	{
		return m_fxQualityLevel;
	}

	public static void SetFxQualityLevel(int level)
	{
		m_fxQualityLevel = level;
	}
}

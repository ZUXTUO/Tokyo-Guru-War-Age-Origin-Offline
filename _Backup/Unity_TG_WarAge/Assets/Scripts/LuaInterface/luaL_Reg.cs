namespace LuaInterface
{
	public struct luaL_Reg
	{
		public string name;

		public LuaCSFunction func;

		public luaL_Reg(string n, LuaCSFunction f)
		{
			name = n;
			func = f;
		}
	}
}

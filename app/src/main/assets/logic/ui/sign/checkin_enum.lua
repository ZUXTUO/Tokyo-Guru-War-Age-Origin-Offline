module("CheckinEnum", package.seeall)
CHECKIN_TYPE = 
{
	SEVEN_CHECKIN = 1,
	MONTH_CHECKIN = 2,
}

SEVEN_STATE = 
{
	SUCCESS = 0,
	DATA_UNLOAD = 1,
	TODAT_CHECKED = 2,
	UNKNOW1 = 3,
	UNKNOW2 = 4,
}

MONTH_DAY = 
{
	[1] = 31,
	[2] = 28,
	[3] = 31,
	[4] = 30,
	[5] = 31,
	[6] = 30,
	[7] = 31,
	[8] = 31,
	[9] = 30,
	[10] = 31,
	[11] = 30,
	[12] = 31,
}

MONTH_DAY_TEXT = {
    [1] = "一",
    [2] = "二",
    [3] = "三",
    [4] = "四",
    [5] = "五",
    [6] = "六",
    [7] = "七",
    [8] = "八",
    [9] = "九",
    [10] = "十",
    [11] = "十一",
    [12] = "十二",
}
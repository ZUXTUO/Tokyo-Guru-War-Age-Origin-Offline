module("CardEnum", package.seeall)
-- 克制类型
local restraint_type = 
{
	Firm = 1,			--坚
	Fast = 2,			--疾
	Sharp = 3,			--锐
	Special = 4,		--特
}
-- 克制类型对应图片
local type_to_image =
{
	[restraint_type.Firm] = "diban1_1",
	[restraint_type.Fast] = "diban2_3",
	[restraint_type.Sharp] = "diban3_1",
	[restraint_type.Special] = "diban4_4",
}
-- 稀有度类型从低到高
rare_type = 
{
	N = 1,
	R = 2,
	SR = 3,
	SSR = 4,
	UR	= 5,
}
-- 稀有度对应图片
local rare_to_image =
{
	[rare_type.N] = "diban1_3",
	[rare_type.R] = "diban2_4",
	[rare_type.SR] = "diban3_2",
	[rare_type.SSR] = "diban4_2",
	[rare_type.UR] = "diban4_2",
}

local team_index_bk_to_image = 
{

}

local team_index_to_image = 
{
}

function TypeToImage(restraintType)
	return type_to_image[restraintType];
end

function RareToImage(rareType)
	return rare_to_image[rareType];
end

function TeamIndexToImage(team_index)
    return team_index_to_image[team_index];
end

function TeamIndexBkToImage(team_index)
    return team_index_bk_to_image[team_index];
end

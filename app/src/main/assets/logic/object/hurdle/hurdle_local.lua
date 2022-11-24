HurdleLocal = 
{

}



local result = 
{
	{id = 1, dataid = 1},
	{id = 5, dataid = 5},
}

function HurdleLocal.cg_hurdle_fight_result(id, use_time, star, callback)
	timer.create("HurdleLocal.gc_hurdle_fight_result",1000,1);
	HurdleLocal.hurdleId = id
	HurdleLocal.star = star;
	HurdleLocal.callback = callback;
end


function HurdleLocal.gc_hurdle_fight_result()
	HurdleLocal.callback(HurdleLocal.hurdleId, HurdleLocal.star, result);
end
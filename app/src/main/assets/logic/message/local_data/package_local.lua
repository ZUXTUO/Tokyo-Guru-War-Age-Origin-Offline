local _timerId = nil;
local gc_packageLocal = {};
gc_packageLocal[1] = {
  [1]={
    number=30000005,
    type=4,
    organize_level=1,
    order=4,
    unique_level=1,
    leader_level=1,
    equip={
      [1]=0,
      [2]=0,
      [3]=0,
      [4]=0,
      [5]=0,
      [6]=0,
      [7]=0,
      [8]=0,
    },
    composite_protect=0,
    cur_exp=0,
    break_through=0,
    lock=0,
    check=0,
    awake=0,
    dataid="6167577387891490818",
    level=1,
  },
  [2]={
    number=30000003,
    type=2,
    organize_level=1,
    order=3,
    unique_level=1,
    leader_level=1,
    equip={
      [1]=0,
      [2]=0,
      [3]=0,
      [4]=0,
      [5]=0,
      [6]=0,
      [7]=0,
      [8]=0,
    },
    composite_protect=0,
    cur_exp=0,
    break_through=0,
    lock=0,
    check=0,
    awake=0,
    dataid="6167577387891474434",
    level=1,
  },
  [3]={
    number=30000005,
    type=4,
    organize_level=1,
    order=5,
    unique_level=1,
    leader_level=1,
    equip={
      [1]=0,
      [2]=0,
      [3]=0,
      [4]=0,
      [5]=0,
      [6]=0,
      [7]=0,
      [8]=0,
    },
    composite_protect=0,
    cur_exp=0,
    break_through=0,
    lock=0,
    check=0,
    awake=0,
    dataid="6169349534347444226",
    level=1,
  },
  [4]={
    number=30000002,
    type=4,
    organize_level=1,
    order=2,
    unique_level=1,
    leader_level=1,
    equip={
      [1]=0,
      [2]=0,
      [3]=0,
      [4]=0,
      [5]=0,
      [6]=0,
      [7]=0,
      [8]=0,
    },
    composite_protect=0,
    cur_exp=0,
    break_through=0,
    lock=0,
    check=0,
    awake=0,
    dataid="6167577387891458050",
    level=1,
  },
  [5]={
    number=30000001,
    type=2,
    organize_level=1,
    order=1,
    unique_level=1,
    leader_level=1,
    equip={
      [1]=0,
      [2]=0,
      [3]=0,
      [4]=0,
      [5]=0,
      [6]=0,
      [7]=0,
      [8]=0,
    },
    composite_protect=0,
    cur_exp=0,
    break_through=0,
    lock=0,
    check=0,
    awake=0,
    dataid="6167577387891441666",
    level=1,
  },
}
gc_packageLocal[2] = {
  [1]={
    dataid = "12312312412124214",
    number= 10000001,
    belong = "111111111";
  },
  [2]={
    dataid = "12312312412124204",
    belong = "111111111";
    number= 10000002,
  },
  [3]={
    dataid = "12312312412124254",
    belong = "111111111";
    number= 10000007,
  },
  [4]={
    dataid = "12312312412124217",
    number= 10000001,
  },
  [5]={
    dataid = "12312312412124224",
    number= 10000007,
  },
  [6]={
    dataid = "12312312412124242",
    number= 10000004,
  },
  [7]={
    dataid = "12312312412124212",
    number= 10000005,
  },
}
gc_packageLocal[3] = {
  
}
gc_package_data = {};
function gc_package_data.cg()
  _timerId = timer.create("gc_package_data.gc", 50, 1);
end 

function gc_package_data.gc()
  msg_cards.gc_role_cards_list(gc_packageLocal[1],true);
  msg_cards.gc_equip_cards_list(gc_packageLocal[2],true);
  msg_cards.gc_item_cards_list(gc_packageLocal[3],true);
  if _timerId then
    timer.stop(_timerId)
  end
  
end

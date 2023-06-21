--[[
	邮件单机数据
]]
--声明timer, 延迟返回使用
local _timerId = nil

-------------------------------------返回邮件列表-------------------------------------
local _mailData = {}

_mailData.mails={
	[1]={
		del_date=1447034788,
		dataid="6172017417708437506",
		title="标题",
		create_date=1437034788,
		have_acc=0,
		is_read=0,
		type=0,
		sender_name="system",
	},
	[2]={
		del_date=1447035788,
		dataid="6172017417708388354",
		title="标题",
		create_date=1437034788,
		have_acc=0,
		is_read=0,
		type=0,
		sender_name="system",
	},
	[3]={
		del_date=0,
		dataid="6172017417708339202",
		title="标题",
		create_date=1437034788,
		have_acc=1,
		is_read=0,
		type=0,
		sender_name="system",
	},
	[4]={
		del_date=0,
		dataid="6172017417708290050",
		title="标题",
		create_date=1437034788,
		have_acc=0,
		is_read=0,
		type=0,
		sender_name="system",
	},
	[5]={
		del_date=0,
		dataid="6172017417708240898",
		title="标题",
		create_date=1437034788,
		have_acc=0,
		is_read=0,
		type=0,
		sender_name="system",
	},
	[6]={
		del_date=0,
		dataid="6172017417708191746",
		title="标题",
		create_date=1437034788,
		have_acc=1,
		is_read=1,
		type=0,
		sender_name="system",
	},
	[7]={
		del_date=0,
		dataid="6172017001096265730",
		title="标题",
		create_date=1437034691,
		have_acc=0,
		is_read=1,
		type=0,
		sender_name="system",
	},
	[8]={
		del_date=0,
		dataid="6172017001096265740",
		title="标题",
		create_date=1437034691,
		have_acc=0,
		is_read=1,
		type=0,
		sender_name="system",
	},
	[9]={
		del_date=0,
		dataid="6172017001096265751",
		title="标题",
		create_date=1437034691,
		have_acc=0,
		is_read=1,
		type=0,
		sender_name="system",
	},
	[10]={
		del_date=0,
		dataid="6172017001096265762",
		title="标题",
		create_date=1437034691,
		have_acc=0,
		is_read=1,
		type=0,
		sender_name="system",
	},
}
_mailData.mailcount = 7
_mailData.ret = 0

gc_get_maildata = {}
function gc_get_maildata.cg()
 	_timerId = timer.create("gc_get_maildata.gc", 1000, 1);
end 

function gc_get_maildata.gc()
	timer.stop(_timerId)
	msg_mail.gc_get_maildata(_mailData.ret, _mailData.mails, _mailData.mailcount )
end


-------------------------------------返回邮件详情-------------------------------------
local _mail_id = nil;
local _mailDetail = {}

_mailDetail.accessory = {}
_mailDetail.accessory.role_dataidlist = {}
_mailDetail.accessory.equip_dataidlist = {}
_mailDetail.accessory.item_dataidlist = {}
_mailDetail.content = "哈哈哈,我是测试内容!!!"

local _mailDetailEx = {}
_mailDetailEx.accessory = {}
_mailDetailEx.accessory.role_dataidlist = {}
_mailDetailEx.accessory.equip_dataidlist = {}
_mailDetailEx.accessory.item_dataidlist = {}

_mailDetailEx.accessory.role_dataidlist[1] = {number = 30001000}
_mailDetailEx.accessory.role_dataidlist[2] = {number = 30001007}
_mailDetailEx.accessory.equip_dataidlist[1] = {number = 10000010}
_mailDetailEx.accessory.item_dataidlist[1] = {number = 20000021, count=100}
_mailDetailEx.accessory.item_dataidlist[2] = {number = 2, count=999999}
_mailDetailEx.content = "哈哈哈,我是测试内容!!!附件"

gc_mail_detail = {}
function gc_mail_detail.cg(mail_dataid)
	_mail_id = mail_dataid;
	_timerId = timer.create("gc_mail_detail.gc", 1000, 1);
end

function gc_mail_detail.gc()
	local data = {};
	for i, v in ipairs(_mailData.mails) do
		if v.dataid == _mail_id then
			data = v;
			break;
		end
	end
	if data.have_acc == 1 then
		msg_mail.gc_mail_detail(0, _mail_id, _mailDetailEx)
	else
		msg_mail.gc_mail_detail(0, _mail_id, _mailDetail)
	end
	timer.stop(_timerId)
end


----------------------------------领取邮件附件-----------------------------------
gc_take_accessory = {}

function gc_take_accessory.cg(mail_dataid)
	_mail_id = mail_dataid;
	_timerId = timer.create("gc_take_accessory.gc", 1000, 1);
end

function gc_take_accessory.gc()
	timer.stop(_timerId)
	msg_mail.gc_take_accessory(0, _mail_id);
end


----------------------------------主动删除邮件-----------------------------------
gc_delete_mail = {}

function gc_delete_mail.cg(mail_dataid)
	_mail_id = mail_dataid;
	_timerId = timer.create("gc_delete_mail.gc", 1000, 1);
end

function gc_delete_mail.gc()
	timer.stop(_timerId)
	msg_mail.gc_delete_mail(0, _mail_id);
end



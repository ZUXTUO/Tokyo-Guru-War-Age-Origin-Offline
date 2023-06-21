-- region : debug_msg.lua
-- Author : kevin
-- Date   : 2014/12/19
-- Usage  : like debug view...

-- ÿ���˵Ĺ�������һ���� ���� ����дһ�� my_debug_msg.lua����Ҫ�ϴ��� Ȼ�󸲸� "sprint������Ϣ����" �� "ϵͳ������Ϣ����" 

---------------------------------------------------------------------------------------------------------------
if false then 
    -- sprint������Ϣ����,
    local sprint_filter = {
        enable = false,
        included =
        {
            '*',
            -- 'create',
            -- 'mark1',
            -- 'mark2',
        },

        excluded =
        {
            -- '*',    	
            -- 'create',
            -- 'mark1',
            -- 'mark2',
        },
    }

    if old_app_log == nil then
        old_app_log = app.log
    end

    if old_app_log_warning == nil then
        old_app_log_warning = app.log_warning
    end

    if old_app_log_error == nil then
        old_app_log_error = app.log
    end

    if old_sprint == nil then
        old_sprint = sprint
    end

    local function msg_filter(str, func)
        for k, v in pairs(sprint_filter.excluded) do
            if v == '*' then
                return
            end

            if string.find(str, v) then
                return
            end
        end

        local do_print = false
        for k, v in pairs(sprint_filter.included) do
            if v == '*' then
                do_print = true
                break
            end

            if string.find(str, v) then
                do_print = true
                break
            end
        end


        if do_print then
            func(str)
        end
    end

    app.log = function (msg)
        msg_filter(msg, old_app_log)
    end

    app.log_warning = function (msg)
        msg_filter(msg, old_app_log_warning)
    end

    app.log = function (msg)
        msg_filter(msg, old_app_log_error)
    end

else 
    local myFilterFile = "logic/public/my_debug_msg.lua";
    if file.exist(myFilterFile) then
        script.run(myFilterFile);
    end
end
-- endregion

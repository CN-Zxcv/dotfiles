-- ~/.config/nvim/lua/linters/xmake_lint.lua
local lint = require("lint")

-- 向上查找文件
local function find_file_upward(filename)
    local dir = vim.fn.getcwd()
    while dir ~= "/" do
        local path = dir .. "/" .. filename
        if vim.loop.fs_stat(path) then
            return path
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return nil
end

local function read_json(path)
    local fd = io.open(path, "r")
    if not fd then
        return nil
    end
    local content = fd:read("*a")
    fd:close()
    if not content or content == "" then
        return nil
    end
    local ok, result = pcall(vim.json.decode, content)
    if ok then
        return result
    else
        print("JSON decode error in", path)
        return nil
    end
end

local function lint_into_quickfix(messages)
    local qf_items = {}
    for _, err in ipairs(messages) do
        table.insert(qf_items, {
            filename = err.filename,
            lnum = err.lnum,
            col = err.col,
            text = err.message,
            type = err.severity == vim.diagnostic.severity.ERROR and "E" or "W",
        })
    end

    vim.fn.setqflist(qf_items, "r")

    if #qf_items > 0 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

lint.linters.xmake = {
    cmd = "xmake",
    args = { "build", "-r", "game"},
    stdin = true,
    ignore_exitcode = true,
    parser = function(output, _, linter_cwd)
        -- print('linter_cwd', linter_cwd, output)
        local ret = {}
        for _, line in ipairs(vim.split(output, "\n", { plain = true })) do
            -- 示例匹配 GCC/Clang 风格错误: file:line:col: error: message
            local file, lnum, col, severity, message = line:match("^(.+):(%d+):(%d+):%s+(.-):%s+(.+)")
            if file and lnum then
                table.insert(ret, {
                    filename = file,
                    lnum = tonumber(lnum),
                    col = tonumber(col),
                    severity = severity:find("error", 1, true) and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                    message = message,
                    source = 'xmake',
                })
            end

        end

        lint_into_quickfix(ret)

        return ret
    end,
}

lint.linters.gcc = function(bufnr)
    if not bufnr then
        bufnr = vim.api.nvim_get_current_buf()
    end
    if not bufnr then
        print("No buffer")
        return
    end
    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename == "" then
        print("No file")
        return nil  -- 跳过
    end

    -- 从 compile_commands.json 获取参数（简化版）
    local args = { "-fsyntax-only" }  -- ← 这里替换成你的逻辑

    -- 尝试读取 compile_commands.json 并构造 args
    local cc_path = find_file_upward("compile_commands.json")
    if cc_path then
        local cc = read_json(cc_path)
        if cc then
            for _, entry in ipairs(cc) do
                if vim.fn.fnamemodify(entry.file, ":p") == vim.fn.fnamemodify(filename, ":p") then
                    local cmd_parts
                    if entry.arguments and type(entry.arguments) == "table" then
                        -- 使用 arguments 数组（更可靠）
                        cmd_parts = entry.arguments
                    elseif entry.command and type(entry.command) == "string" then
                        -- 回退到 command 字符串
                        cmd_parts = vim.split(entry.command, " ", { plain = true })
                    else
                        -- 两者都没有，跳过
                        break
                    end
                    -- 移除 -o 和输出文件，保留其他 flags
                    local new_args = { "-fsyntax-only" }
                    local skip_next = false
                    for i, arg in ipairs(cmd_parts) do
                        if skip_next then
                            skip_next = false
                        elseif arg == "-o" then
                            skip_next = true
                        elseif i > 1 then  -- 跳过编译器路径（gcc/clang）
                            table.insert(new_args, arg)
                        end
                    end
                    args = new_args
                    break
                end
            end
        end
    end

    -- 返回完整的 linter spec（静态结构）
    -- local pattern = [[^([^:]+):(%d+):(%d+):%s+([^:]+):%s+(.*)$]]
    local pattern = "^(.+):(%d+):(%d+):%s+(.-):%s+(.+)"
    local groups = { 'file', 'lnum', 'col', 'severity', 'message' }
    local severity_map = {
        ['error'] = vim.diagnostic.severity.ERROR,
        ['warning'] = vim.diagnostic.severity.WARN,
        ['performance'] = vim.diagnostic.severity.WARN,
        ['style'] = vim.diagnostic.severity.INFO,
        ['information'] = vim.diagnostic.severity.INFO,
    }
    local ret = {
        cmd = "gcc",
        args = args,
        stdin = false,
        append_name = true,
        ignore_exitcode = true,
        env = nil,
        stream = 'stderr',
        parser = require('lint.parser').from_pattern(pattern, groups, severity_map, {source='gcc'}),
    }
    return ret
end

lint.linters_by_ft = {
  c = { "gcc" },
  cpp = { "xmake" },
}

local function try_quickfix()
    -- lint 没有完成回调，需要外部判断完成，然后拉起quickfix
    if #lint.get_running() > 0 then
        vim.schedule(try_quickfix)
    else
        vim.diagnostic.setqflist(t)
        if #vim.diagnostic.get(0) > 0 then
            vim.cmd('copen')
        end
    end
end

-- 保存文件自动触发 lint
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        lint.try_lint()
        vim.schedule(try_quickfix)
    end,
})

-- 创建 :Lint 命令
vim.api.nvim_create_user_command("Lint", function()
    lint.try_lint()
    vim.schedule(try_quickfix)
end, {})


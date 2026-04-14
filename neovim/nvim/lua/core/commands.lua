local function delete_file_and_buffer()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        vim.notify("No file associated with this buffer", vim.log.levels.ERROR)
        return
    end

    local choice = vim.fn.confirm("Delete " .. filepath .. "?", "&Yes\n&No", 1)
    if choice == 1 then
        os.remove(filepath)
        vim.api.nvim_buf_delete(0, { force = true })
    end
end

vim.api.nvim_create_user_command('Rm', delete_file_and_buffer, {})
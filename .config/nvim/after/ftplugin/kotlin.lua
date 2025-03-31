-- ~/.config/nvim/ftplugin/kotlin.lua

-- Function to get the correct package name from build.gradle
local function get_package_name()
    -- Try to find the applicationId in build.gradle.kts or build.gradle
    local package_name = nil
    local gradle_files = {
        vim.fn.expand('%:p:h:h:h') .. '/app/build.gradle.kts',
        vim.fn.expand('%:p:h:h:h') .. '/app/build.gradle',
    }

    for _, file in ipairs(gradle_files) do
        if vim.fn.filereadable(file) == 1 then
            local lines = vim.fn.readfile(file)
            for _, line in ipairs(lines) do
                local match = string.match(line, 'applicationId%s*=%s*"([^"]+)"')
                if match then
                    package_name = match
                    break
                end
            end
            if package_name then
                break
            end
        end
    end

    return package_name or 'com.example.myapplication' -- Fallback to your current package name
end

-- Function to get the project root directory
local function get_project_root()
    local current_dir = vim.fn.expand('%:p:h')
    local root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
    }

    -- Walk up directories until we find a root marker
    local dir = current_dir
    while dir ~= '/' do
        for _, marker in ipairs(root_markers) do
            if vim.fn.filereadable(dir .. '/' .. marker) == 1 then
                return dir
            end
        end
        dir = vim.fn.fnamemodify(dir, ':h')
    end

    -- If we can't find a root marker, just use the current directory
    return current_dir
end

-- Function to run the Kotlin Android app
local function run_kotlin_app()
    -- Save current buffer
    vim.cmd('write')

    -- Get project root and package name
    local project_root = get_project_root()
    local package_name = get_package_name()

    -- Execute the commands
    local terminal_cmd = string.format(
        'cd %s && '
            .. './gradlew assembleDebug && '
            .. 'adb install -r app/build/outputs/apk/debug/app-debug.apk && '
            .. 'adb shell am start -n %s/.MainActivity',
        vim.fn.shellescape(project_root),
        package_name
    )

    -- Open in a new terminal buffer
    vim.cmd('botright new | terminal ' .. terminal_cmd)
    vim.cmd('startinsert')
end

local function apply_kotlin_changes()
    -- Save current buffer
    vim.cmd('write')

    -- Get project root
    local project_root = get_project_root()

    -- Apply changes without full restart
    local terminal_cmd = string.format(
        'cd %s && ' .. 'adb shell am broadcast -a com.android.tools.deployment.APPLY_CHANGES',
        vim.fn.shellescape(project_root)
    )

    -- Show a small notification instead of new terminal
    vim.cmd('echo "Applying changes..."')
    vim.fn.jobstart(terminal_cmd, {
        on_exit = function(_, code)
            if code == 0 then
                vim.cmd('echo "Changes applied successfully"')
            else
                vim.cmd('echo "Failed to apply changes"')
            end
        end,
    })
end

-- Set the mappings
vim.keymap.set('n', '<leader>R', run_kotlin_app, { buffer = true, desc = 'Run Kotlin App on Android' })
vim.keymap.set('n', '<leader>r', apply_kotlin_changes, { buffer = true, desc = 'Apply Changes to Kotlin App' })

function color_zeros(col, row, mode)
    local val = sc.lgetnum(col, row)
    if val == 0 then
        -- Use cellcolor command to color the cell
        sc.lquery(":cellcolor " .. string.char(65 + col) .. row .. " \"fg=BLACK bg=WHITE\"")
    end
end

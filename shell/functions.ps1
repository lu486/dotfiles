# SSH quick connect
function s {
    $host_entry = Get-Content ~/.ssh/config | ForEach-Object {
        if ($_ -match '^#\s*={3,}') { $script:comment = '' }
        elseif ($_ -match '^#\s*(.+)') { $script:comment = $Matches[1] }
        elseif ($_ -match '^Host\s+(\S+)' -and $_ -notmatch '\*' -and $Matches[1] -notmatch '^\d') {
            '{0,-15} {1}' -f $Matches[1], $script:comment
            $script:comment = ''
        }
    } | fzf --height=50% --reverse --prompt='SSH > '
    if ($host_entry) { ssh ($host_entry -split '\s+')[0] }
}

# SSH 快速连接 - 输入 s 打开服务器列表
function s() {
  local host
  host=$(awk '
    /^#/ && !/^# ==/ { comment=$0; next }
    /^#/ && /^# ==/ { comment=""; next }
    /^Host / && !/\*/ && $2 !~ /^[0-9]/ {
      name=$2
      desc=comment; gsub(/^# */, "", desc)
      printf "%-15s %s\n", name, desc
      comment=""
    }
  ' ~/.ssh/config | fzf --height=50% --reverse --prompt="SSH > " | awk '{print $1}')
  [[ -n "$host" ]] && ssh "$host"
}

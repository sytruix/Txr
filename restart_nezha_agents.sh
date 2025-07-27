#!/bin/bash
echo "开始重启 nezha-agent*.service 服务..."

services=$(systemctl list-units --type=service --no-legend | grep '^nezha-agent.*\.service$' | awk '{print $1}')

if [ -z "$services" ]; then
  echo "未找到匹配的 nezha-agent 服务。"
  exit 1
fi

for svc in $services; do
  echo "正在重启服务：$svc"
  sudo systemctl restart "$svc"
  if [ $? -eq 0 ]; then
    echo "服务 $svc 重启成功。"
  else
    echo "服务 $svc 重启失败！"
  fi
done

echo "全部服务处理完成。"

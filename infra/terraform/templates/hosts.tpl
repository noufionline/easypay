[master]
%{ for ip in master_ips ~}
${ip}
%{ endfor ~}

[workers]
%{ for ip in worker_ips ~}
${ip}
%{ endfor ~}
service "mysqld" do
    action [ :restart ]
end

service "php-fpm" do
    action [ :restart ]
end

service "nginx" do
    action [ :restart ]
end


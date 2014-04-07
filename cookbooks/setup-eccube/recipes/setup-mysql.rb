include_recipe 'database::mysql'

mysql_connection_info = {
  :host => "localhost",
  :username => 'root',
  :password => ''
}

mysql_database "#{node[:mysql][:database_name]}" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "#{node[:mysql][:database_user]}" do
  connection mysql_connection_info
  password "#{node[:mysql][:database_pass]}"
  database_name "#{node[:mysql][:database_name]}"
  privileges [:all]
  action [:create, :grant]
end


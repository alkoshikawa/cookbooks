directory "/tmp/eccube" do
  owner "root"
  group "root"
  recursive true
  mode 0755
  action :create
  not_if "ls /tmp/eccube"
end

remote_file "/tmp/eccube/eccube.zip" do
  source "http://downloads.ec-cube.net/src/eccube-2.13.1.zip"
end

execute "unzip file, deploy" do
    command <<-EOH
        if [ -d /var/www/eccube ]; then
          rm -rf /var/www/eccube
        fi
        unzip /tmp/eccube/eccube.zip -d /tmp/eccube/_eccube
        mv /tmp/eccube/_eccube/eccube-2.13.1 /var/www/eccube
        rm -rf /tmp/eccube
    EOH
end


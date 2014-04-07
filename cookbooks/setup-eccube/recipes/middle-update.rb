%w{nginx mysql mysql-server}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end

%w{php54 php54-process php54-pdo php54-pspell php54-mysqlnd php54-common php54-pecl-apc php54-mbstring php54-pecl-imagick php54-mcrypt php54-fpm php54-devel php54-cli php54-gd php54-pecl-memcache}.each do |pkg|
  package pkg do
    action [:install, :upgrade]
  end
end


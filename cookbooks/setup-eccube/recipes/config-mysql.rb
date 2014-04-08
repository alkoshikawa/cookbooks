myConf = "/etc/my.cnf"
templatePath = "/usr/local/chef-repo/cookbooks/setup-eccube/templates/default"

ruby_block "copy my.cnf" do
    block do
      instanceType = "#{node[:instance][:type]}"
      if instanceType.index("micro") != -1 then
        resources(:file => "copy_micro").run_action(:create)
      elsif instanceType.index("small") != -1 then
        resources(:file => "copy_small").run_action(:create)
      elsif instanceType.index("large") != -1 then
        resources(:file => "copy_large").run_action(:create)
      else
        resources(:file => "copy_micro").run_action(:create)
      end
    end
end

file "copy_micro" do
    path "#{myConf}"
    owner "root"
    group "root"
    content ::File.open("#{templatePath}/my.cnf.micro").read
    action :nothing
end

file "copy_small" do
    path "#{myConf}"
    owner "root"
    group "root"
    content ::File.open("#{templatePath}/my.cnf.small").read
    action :nothing
end

file "copy_large" do
    path "#{myConf}"
    owner "root"
    group "root"
    content ::File.open("#{templatePath}/my.cnf.large").read
    action :nothing
end

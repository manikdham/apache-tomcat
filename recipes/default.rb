# Cookbook Name:: apache-tomcat
# Recipe:: default
#
# Copyright 2013, Mrigesh Priyadarshi, Lakshmi Prasad
#
# All rights reserved - Do Not Redistribute


#user node['apache-tomcat']['user'] do
#  comment "Tomcat User"
#end

apache_url = "node['apache-tomcat']['url']"

user node[]

bash "tomcat6" do
 user node['apache-tomcat']['user']
 cwd "node['apache-tomcat']['install_dir']"
 code <<-EOH
 s3cmd get #{apache_url}
 tar -xzf #{node['apache-tomcat']['install_file']}
 rm -f #{node['apache-tomcat']['install_file']}
 EOH
  "test -d #{node['apache-tomcat']['install_dir']}/tomcat6"
end

install_dir = "{node['apache-tomcat']['install_dir']}/tomcat6"

directory "install_dir" do
  group node['apache-tomcat']['user']
  owner node['apache-tomcat']['user']
 end
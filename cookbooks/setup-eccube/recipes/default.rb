#
# Cookbook Name:: setup-eccube
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# update middelware
include_recipe 'setup-eccube::middle-update'

# download ec-cube
include_recipe 'setup-eccube::eccube-install'

# setup mysql

# create settings

# deploy settings

# server restart
include_recipe 'setup-eccube::service-restart'

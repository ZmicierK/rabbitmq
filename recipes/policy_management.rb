#
# Cookbook Name:: rabbitmq
# Recipe:: policy_management
#
# Author: Robert Choi <taeilchoi1@gmail.com>
# Copyright 2013 by Robert Choi
# Copyright 2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'rabbitmq::default'

node['rabbitmq']['policies'].each do |name, policy|
  rabbitmq_policy name do
    pattern policy['pattern']
    parameters policy['params']
    priority policy['priority']
    vhost policy['vhost']
    action :set
    notifies :restart, "service[#{node['rabbitmq']['service_name']}]"
  end
end

node['rabbitmq']['disabled_policies'].each do |policy|
  rabbitmq_policy policy do
    action :clear
    notifies :restart, "service[#{node['rabbitmq']['service_name']}]"
  end
end

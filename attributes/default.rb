
default['spacewalk']['server']['db']['type'] = 'postgres'
default['spacewalk']['server']['errata'] = true
default['spacewalk']['hostname'] = node['hostname']

# Answer file configuration
default['spacewalk']['server']['admin_email'] = 'root@localhost'
default['spacewalk']['server']['ssl']['org'] = 'Spacewalk Org'
default['spacewalk']['server']['ssl']['org_unit'] = 'spacewalk'
default['spacewalk']['server']['ssl']['city'] = 'My City'
default['spacewalk']['server']['ssl']['state'] = 'My State'
default['spacewalk']['server']['ssl']['country'] = 'US'
default['spacewalk']['server']['ssl']['password'] = 'spacewalk'
default['spacewalk']['server']['ssl']['email'] = 'root@localhost'
default['spacewalk']['server']['ssl']['config_vhost'] = 'Y'
default['spacewalk']['server']['enable_tftp'] = 'Y'

arch = node['kernel']['machine'] == 'x86_64' ? 'x86_64' : 'i386'

case node['platform_family']
when 'rhel'
  platform_major = node['platform_version'][0]
  default['spacewalk']['server']['repo_url'] = "http://spacewalk.redhat.com/yum/2.3/RHEL/#{platform_major}/#{arch}/spacewalk-repo-2.3-4.el#{platform_major}.noarch.rpm"
when 'fedora'
  default['spacewalk']['server']['repo_url'] = "http://spacewalk.redhat.com/yum/2.3/Fedora/#{node['platform_version']}/#{arch}/spacewalk-repo-2.3-4.fc#{node['platform_version']}.noarch.rpm"
end

case node['spacewalk']['server']['db']['type']
when 'postgres'
  default['spacewalk']['server']['db']['backend'] = 'postgresql'
  default['spacewalk']['server']['db']['name'] = 'spaceschema'
  default['spacewalk']['server']['db']['user'] = 'spaceuser'
  default['spacewalk']['server']['db']['password'] = 'spacepw'
  default['spacewalk']['server']['db']['host'] = 'localhost'
  default['spacewalk']['server']['db']['port'] = 5432
when 'oracle'
  default['spacewalk']['server']['db']['backend'] = 'oracle'
  default['spacewalk']['server']['db']['name'] = 'xe'
  default['spacewalk']['server']['db']['user'] = 'spacewalk'
  default['spacewalk']['server']['db']['password'] = 'spacewalk'
  default['spacewalk']['server']['db']['host'] = 'localhost'
  default['spacewalk']['server']['db']['port'] = 1521
end

# ::ubuntu configuration
default['spacewalk']['sync']['user'] = 'admin'
default['spacewalk']['sync']['password'] = 'admin'
default['spacewalk']['sync']['channels'] = { 'precise' => 'http://de.archive.ubuntu.com/ubuntu/dists/precise/main/binary-amd64/',
                                             'precise-updates' => 'http://de.archive.ubuntu.com/ubuntu/dists/precise-updates/main/binary-amd64/',
                                             'precise-security' => 'http://de.archive.ubuntu.com/ubuntu/dists/precise-security/main/binary-amd64/'
                                           }
default['spacewalk']['sync']['cron']['h'] = '7'
default['spacewalk']['sync']['cron']['m'] = '0'
default['spacewalk']['errata']['exclude-channels'] = "'precise'" # multiple = "'precise','trusty'"
default['spacewalk']['errata']['cron']['h'] = '6'
default['spacewalk']['errata']['cron']['m'] = '0'

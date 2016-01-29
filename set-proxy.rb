unless Vagrant.has_plugin?("vagrant-proxyconf")
  raise "Missing required plugin 'vagrant-proxyconf', run `vagrant plugin install vagrant-proxyconf`"
end

Vagrant.configure(2) do |config|
  # Allows busser gem and deps to be fetched as required
  config.proxy.http     = "#{ENV['http_proxy']}"
  config.proxy.https    = "#{ENV['https_proxy']}"
  config.proxy.no_proxy = "test-centos-server"
  config.vm.network "private_network", ip: "192.168.33.11"
end
	
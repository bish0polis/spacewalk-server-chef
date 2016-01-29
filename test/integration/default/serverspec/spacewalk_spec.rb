require 'spec_helper'

tc_user = 'tomcat'
tc_group = 'tomcat'
spacemcmd_tool = "/usr/bin/spacecmd"
spacewalk_conf = "/etc/spacecmd.conf"
spacewalk_dir = "/opt/spacewalk"
spacewalk_errata_dir = "/opt/spacewalk/errata"


describe 'Spacewalk Service' do
  it 'is listening on port 8080' do
    expect(port(8080)).to be_listening 'tcp'
  end
  it 'has a running service of tomcat' do
    expect(service('tomcat')).to be_running
  end
  it 'has a running service of spacewalk' do
    expect(service('spacewalk-service')).to be_running
  end
end

describe group(tc_group) do
  it { should exist }
end

describe user(tc_user) do
  it { should exist }
  it { should belong_to_group tc_group }
end

describe file(spacemcmd_tool ) do
   it { should be_file }
end

describe file(spacewalk_conf ) do
   it { should be_file }
   its(:content) {should match /username=admin/}
end

describe file(spacewalk_dir ) do
  it { should be_directory }
end

describe file(spacewalk_errata_dir ) do
  it { should be_directory }
end

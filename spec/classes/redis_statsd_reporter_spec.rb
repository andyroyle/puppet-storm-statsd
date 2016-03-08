require 'spec_helper'

describe 'storm_statsd', :type => :class do

  ['Debian', 'RedHat'].each do |osfamily|
    context "using #{osfamily}" do
      let(:facts) { {
        :osfamily => osfamily
      } }

      it { should contain_class('storm_statsd') }
      it { should contain_class('storm_statsd::params') }
      it { should contain_storm_statsd__config }
      it { should contain_package('storm_statsd').with_ensure('present') }
      it { should contain_service('storm-statsd').with_ensure('running') }
      it { should contain_service('storm-statsd').with_enable(true) }

      it { should contain_file('/etc/storm-statsd') }
      it { should contain_file('/etc/storm-statsd/storm.json') }
      it { should contain_file('/etc/storm-statsd/statsd.json') }
      it { should contain_file('/etc/default/storm-statsd') }
      it { should contain_file('/var/log/storm-statsd') }
      it { should contain_file('/usr/local/sbin/storm-statsd') }

      if osfamily == 'Debian'
        it { should contain_file('/etc/init/storm-statsd.conf') }
      end

      if osfamily == 'RedHat'
        it { should contain_file('/etc/init.d/storm-statsd') }
      end

      describe 'stopping the statsd service' do
	let(:params) {{
	  :service_ensure => 'stopped',
        }}
        it { should contain_service('storm-statsd').with_ensure('stopped') }
      end

      describe 'disabling the statsd service' do
	let(:params) {{
	  :service_enable => false,
        }}
        it { should contain_service('storm-statsd').with_enable(false) }
      end

      describe 'disabling the management of the statsd service' do
	let(:params) {{
	  :manage_service => false,
        }}
        it { should_not contain_service('storm-statsd') }
      end
     end
  end

end

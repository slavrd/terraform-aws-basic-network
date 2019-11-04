control 'instanceAccess' do

    title 'EC2 Instance accessibility test'
    desc 'A test that confirms if the EC2 instances provided by the TF outputs are accessible or not.'

    input('public_instances').each do |pub|

        describe host(pub['public_dns'], port: 22, protocol: 'tcp') do
            it { should be_reachable }
            it { should be_resolvable }
        end

    end

    input('private_instances').each do |pub|

        describe host(pub['public_dns'], port: 22, protocol: 'tcp') do
            it { should_not be_reachable }
            it { should be_resolvable }
        end
        
    end

end
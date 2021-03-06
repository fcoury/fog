require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'EC2.describe_security_groups' do
  describe 'success' do

    before(:each) do
      AWS[:ec2].create_security_group('fog_security_group', 'a security group for testing fog')
    end

    after(:each) do
      AWS[:ec2].delete_security_group('fog_security_group')
    end

    it "should return proper attributes with no params" do
      actual = AWS[:ec2].describe_security_groups
      actual.body['requestId'].should be_a(String)
      actual.body['securityGroupInfo'].should be_an(Array)
      security_group = actual.body['securityGroupInfo'].select do |security_group| 
        security_group['groupName'] == 'fog_security_group'
      end.first
      security_group['groupDescription'].should be_a(String)
      security_group['groupName'].should be_a(String)
      security_group['ownerId'].should be_a(String)
      security_group['ipPermissions'].should be_an(Array)

    end

    it "should return proper attributes with params" do
      actual = AWS[:ec2].describe_security_groups('fog_security_group')
      actual.body['requestId'].should be_a(String)
      actual.body['securityGroupInfo'].should be_an(Array)
      security_group = actual.body['securityGroupInfo'].select do |security_group| 
        security_group['groupName'] == 'fog_security_group'
      end.first
      security_group['groupDescription'].should be_a(String)
      security_group['groupName'].should be_a(String)
      security_group['ownerId'].should be_a(String)
      security_group['ipPermissions'].should be_an(Array)
    end

  end
  describe 'failure' do

    it "should raise a BadRequest error if the security group does not exist" do
      lambda {
        AWS[:ec2].describe_security_groups('not_a_security_group')
      }.should raise_error(Excon::Errors::BadRequest)
    end

  end
end

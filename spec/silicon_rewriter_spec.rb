require 'spec_helper'
require 'silicon_rewriter/rewriter'

describe SiliconRewriter::Rewriter do
  let(:application) { mock }
  let(:rules) do
    [
      { host: 'localhost', from: '/robots.txt', to: '/robots.fr.txt' },
      { host: 'localhost', from: '/404.txt',    to: '/404.fr.txt' }
    ]
  end

  subject { SiliconRewriter::Rewriter.new(application, { rules: rules }) }

  describe '#initialize' do
    context 'when rules is nil' do
      it 'raises an exception' do
        expect { SiliconRewriter::Rewriter.new(application, {}) }.to raise_error("'rules' option is required")
      end
    end
  end

  describe '#call' do
    let(:environment) { {} }

    it 'calls application.call with environment' do
      subject.stub(:matching_rule)
      application.should_receive(:call).with(environment)
      subject.call(environment)
    end

    context 'when there is a matching rule' do
      before(:each) do
        subject.stub(:matching_rule).and_return(rules.first)
        application.stub(:call)
        subject.call(environment)
      end

      it 'sets the REQUEST_URI with destination' do
        environment['REQUEST_URI'].should == rules.first[:to]
      end

      it 'sets the PATH_INFO with destination' do
        environment['PATH_INFO'].should == rules.first[:to]
      end

      it 'empties the QUERY_STRING' do
        environment['QUERY_STRING'].should be_empty
      end
    end

    context 'when there is no matching rule' do
      before(:each) { subject.stub(:matching_rule).and_return(nil) }

      it 'does not change the REQUEST_URI' do
        expect { environment['REQUEST_URI'] }.to_not change { environment['REQUEST_URI'] }
      end

      it 'does not change the PATH_INFO' do
        expect { environment['PATH_INFO'] }.to_not change { environment['PATH_INFO'] }
      end

      it 'does not change the QUERY_STRING' do
        expect { environment['QUERY_STRING'] }.to_not change { environment['QUERY_STRING'] }
      end
    end
  end

  describe '#matching_rule' do
    let(:environment) { {} }
    let(:rack_request) { mock }

    before(:each) do
      application.stub(:call)
    end

    context 'when there is no matching rule' do
      it 'returns nil' do
        rack_request.stub(:host).and_return('awesome-website.fr')
        rack_request.stub(:path_info).and_return('/awesome-route')
        ::Rack::Request.stub(:new).with(environment).and_return(rack_request)

        subject.send(:matching_rule, environment).should be_nil
      end
    end

    context 'when there is a rule only matching the host' do
      it 'returns nil' do
        rack_request.stub(:host).and_return('localhost')
        rack_request.stub(:path_info).and_return('/awesome-route')
        ::Rack::Request.stub(:new).with(environment).and_return(rack_request)

        subject.send(:matching_rule, environment).should be_nil
      end
    end

    context 'when there is a rule only matching the desired destination' do
      it 'returns nil' do
        rack_request.stub(:host).and_return('awesome-website.fr')
        rack_request.stub(:path_info).and_return('/robots.txt')
        ::Rack::Request.stub(:new).with(environment).and_return(rack_request)

        subject.send(:matching_rule, environment).should be_nil
      end
    end

    context 'when there is a rule matching the request' do
      it 'return the rule' do
        rack_request.stub(:host).and_return('localhost')
        rack_request.stub(:path_info).and_return('/robots.txt')
        ::Rack::Request.stub(:new).with(environment).and_return(rack_request)

        subject.send(:matching_rule, environment).should == rules.first
      end
    end
  end
end

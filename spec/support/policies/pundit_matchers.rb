# frozen_string_literal: true

RSpec::Matchers.define :permit do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.resource.inspect} for #{policy.current_user}"
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.resource.inspect} for #{policy.current_user}"
  end
end

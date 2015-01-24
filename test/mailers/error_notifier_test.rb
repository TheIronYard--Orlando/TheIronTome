require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  setup do
    ErrorDuck = Class.new do
      def backtrace
        [
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activerecord-4.1.8/lib/active_record/relation/finder_methods.rb:320:in `raise_record_not_found_exception!'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activerecord-4.1.8/lib/active_record/relation/finder_methods.rb:429:in `find_one'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activerecord-4.1.8/lib/active_record/relation/finder_methods.rb:413:in `find_with_ids'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activerecord-4.1.8/lib/active_record/relation/finder_methods.rb:68:in `find'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activerecord-4.1.8/lib/active_record/querying.rb:3:in `find'",
          "/Users/stevegod/Code/agile-webdev/depot/app/controllers/orders_controller.rb:80:in `set_order'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:424:in `block in make_lambda'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:143:in `call'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:143:in `block in halting_and_conditional'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:149:in `call'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:149:in `block in halting_and_conditional'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:229:in `call'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:229:in `block in halting'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:166:in `call'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:166:in `block in halting'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:166:in `call'",
          "/Users/stevegod/.gem/ruby/2.2.0/gems/activesupport-4.1.8/lib/active_support/callbacks.rb:166:in `block in halting'"
        ]
      end

      def message
        "Couldn't find Order with 'id'=309210040219412"
      end
    end
    @error = ErrorDuck.new
  end

  test "failed" do
    mail = ErrorNotifier.failed(@error)
    assert_equal "Failed", mail.subject
    assert_equal [ENV["ADMIN_EMAIL"]], mail.to
    assert_equal ["deevo.lopemint@gmail.com"], mail.from
    assert_match "Pragmatic Bookshelf Depot Failed", mail.body.encoded
    assert_match "raise_record_not_found_exception", mail.body.encoded
    assert_match "309210040219412", mail.body.encoded
  end

end

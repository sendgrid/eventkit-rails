FactoryGirl.define do
    factory :event do
        timestamp               Time.now.to_i
        event                   {["bounce", "click", "deferred", "delivered", "dropped", "open", "processed", "spamreport", "unsubscribe", "group_unsubscribe", "group_resubscribe"].sample}
        sequence(:email) { |n| "awesomeemail#{n}@example.none"}
        sequence(:"smtp-id") { |n| "LU6cMZ9jhyWNCv5xJ4e831oVu#{n}"}
        sequence(:"sg_event_id") { |n| "FyYtL0ZDIuhbsTh2RZynZk8bQaSMgopRBGpy0sfJzJCFWyV#{n}"}
        sequence(:"sg_message_id") { |n| "9gyRRQgAVT5rZqLTZSr1ykhSSdM2BE6#{n}"}
        category                '["Test","Newsletter"]'
        newsletter              '{"newsletter_id":12345,"newsletter_user_list_id":67890,"newsletter_send_id":4815162342}'
        response                "250 OK"
        reason                  "Bounced Address"
        ip                      {["12.345.67.890","98.765.43.210"].sample}
        useragent               "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Mobile/123456"
        attempt                 0
        status                  "5.0.0"
        type_id                 "block"
        url                     "https://sendgrid.com"
        additional_arguments    '{"foo":"bar"}'
        event_post_timestamp    Time.now.to_i
    end
end
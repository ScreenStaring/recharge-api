require "rake"
require "recharge"

namespace :recharge do
  namespace :hooks do
    task :_setup_recharge do
      abort "RECHARGE_API_KEY required" unless ENV["RECHARGE_API_KEY"]
      ReCharge.api_key = ENV["RECHARGE_API_KEY"]
    end

    desc "List webhooks for RECHARGE_API_KEY"
    task :list => :_setup_recharge do
      format = "%-5s %-25s %-80s\n"
      printf format, "ID", "Hook", "URL"

      Recharge::Webhook.list.each do |hook|
        printf format, hook.id, hook.topic, hook.address
      end
    end

    desc "Delete webhooks for RECHARGE_API_KEY"
    task :delete_all => :_setup_recharge do
      Recharge::Webhook.list.each { |hook| hook.class.delete(hook.id) }
    end

    desc "Delete the webhooks given by the ID(s) in ID for RECHARGE_API_KEY"
    task :delete => :_setup_recharge do
      ids = ENV["ID"].to_s.strip.split(",")
      abort "ID required" unless ids.any?

      ids.each do |id|
        puts "Deleting webhook #{id}"
        Recharge::Webhook.delete(id)
      end
    end

    desc "Create webhook HOOK to be sent to CALLBACK for RECHARGE_API_KEY"
    task :create => :_setup_recharge do
      known_hooks = %w[
        subscription/created
        subscription/updated
        subscription/activated
        subscription/cancelled
        customer/created
        customer/updated
        order/created
        charge/created
        charge/paid
      ]

      abort "CALLBACK required" unless ENV["CALLBACK"]
      abort "HOOK required" unless ENV["HOOK"]
      abort "unknown hook #{ENV["HOOK"]}" unless known_hooks.include?(ENV["HOOK"])

      puts "Creating webhook #{ENV["HOOK"]} for #{ENV["CALLBACK"]}"

      hook = Recharge::Webhook.create(
        :topic   => ENV["HOOK"],
        :address => ENV["CALLBACK"]
      )

      puts "Created hook ##{hook.id}"
    end
  end
end

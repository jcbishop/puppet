module MCollective
  module Agent
    class Checkmailqueue<RPC::Agent
      action "check" do
        reply[:status] = run("/usr/bin/mailq |awk '/^[0-9,A-F]/ {print $1}' |wc -l", :stdout => :output, :stderr => :errors, :chomp => true)
      end

      action "flush" do
        reply[:status] = run("/usr/sbin/postqueue -f", :stdout => :output, :stderr => :errors, :chomp => true)
      end

      action "purge" do
        reply[:status] = run("/usr/sbin/postsuper -d ALL", :stdout => :output, :stderr => :errors, :chomp => true)
      end

    end
  end
end

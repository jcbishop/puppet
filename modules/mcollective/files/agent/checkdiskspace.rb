module MCollective
  module Agent
    class Checkdiskspace<RPC::Agent
      action "check" do
         reply[:status] = run("/bin/df -h", :stdout => :output, :stderr => :errors, :chomp => true)
      end
    end
  end
end

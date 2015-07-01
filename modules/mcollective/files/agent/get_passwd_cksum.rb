module MCollective
  module Agent
    class Get_passwd_cksum<RPC::Agent
      action "check" do
         reply[:status] = run("if [ -f '/tmp/passwd.id' ];then cat /tmp/passwd.id|cut -d':' -f2 |awk '{print $1}';fi", :stdout => :output, :stderr => :errors, :chomp => true)
      end
    end
  end
end

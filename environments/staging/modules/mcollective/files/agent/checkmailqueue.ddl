metadata :name        => "checkmailqueue",
    :description => "Agent to check the mail queue",
    :author      => "J.C. Bishop",
    :license     => "GPLv2",
    :version     => "0.1",
    :url         => "http://twc.com",
    :timeout     => 60

action "check", :description => "Get the size of the mail queue" do
    display :ok

    output   :output,
             :description  => "The results",
             :display_as   => "# Msg in queue: ",
             :default      => ""

    output  :errors,
            :description  => "Errors returns from postqueue command",
            :display_as   => "Errors"
end

action "flush", :description => "Flush the mail queues" do
    display :always

    output   :output,
             :description  => "The results",
             :display_as   => "Result",
             :default      => ""
end

action "purge", :description => "Purge the mailque" do
    display :ok

    #output  :status,
    #        :description => "The status of the purge command",
    #        :display_as => "mail queue purge status",
    #        :default     => ""

    output  :output,
            :description  => "Command output",
            :display_as   => "Purge Results",
            :default      => ""

    #output  :errors,
    #        :description  => "Errors from purge command",
    #        :display_as   => "Errors"
end

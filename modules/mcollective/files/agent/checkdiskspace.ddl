metadata :name        => "checkdiskspace",
    :description => "Agent to check the diskspace",
    :author      => "J.C. Bishop for The Weather Companny",
    :license     => "GPLv2",
    :version     => "0.1",
    :url         => "http://twc.com",
    :timeout     => 60

action "check", :description => "Get the available size of the disk drive" do
    display :ok

    output  :status,
            :description => "The status of the command",
            :display_as  => "df status",
            :default     => "unknown status"

    output   :output,
             :description  => "The results",
             :display_as   => "Result",
             :default      => ""

    output  :errors,
            :description  => "Errors returns from df command",
            :display_as   => "Errors"
end


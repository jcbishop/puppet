metadata :name        => "get_passwd_cksum",
    :description => "Agent to check the md5sum of /etc/passwd",
    :author      => "J.C. Bishop for ISS",
    :license     => "GPLv2",
    :version     => "0.1",
    :url         => "http://issgovernance.com",
    :timeout     => 60

action "check", :description => "Get the md5sum of /etc/passwd" do
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
            :description  => "Errors returns from get_passwd_cksum command",
            :display_as   => "Errors"
end

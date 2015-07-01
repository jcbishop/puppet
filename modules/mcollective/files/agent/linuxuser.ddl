metadata :name        => "linuxuser",
    :description => "Agent to add or modify the linux user account",
    :author      => "J.C. Bishop for ISS",
    :license     => "GPLv2",
    :version     => "0.1",
    :url         => "http://",
    :timeout     => 60

action "check", :description => "Check if the user exists" do
    display :ok

    input    :uid,
	     :prompt       => "userid:",
             :description  => "Users uid",
             :type         => :string,
             :validation   => '.*',
             :optional     => false,
             :maxlength    => 32

    output   :output,
             :description  => "The results",
             :display_as   => "userinfo: ",
             :default      => ""

end

action "add", :description => "Add a new user account" do
    display :always

    output   :output,
             :description  => "The results",
             :display_as   => "Result",
             :default      => ""
end

action "delete", :description => "Delete the useraccount" do
    display :ok

    output  :output,
            :description  => "Command output",
            :display_as   => "delete Results",
            :default      => ""

action "modify", :description => "modify the useraccount" do
    display :ok

    output  :output,
            :description  => "Command output",
            :display_as   => "modify Results",
            :default      => ""

end
